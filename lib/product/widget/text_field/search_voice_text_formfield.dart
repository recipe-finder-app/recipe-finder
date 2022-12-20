import 'package:avatar_glow/avatar_glow.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/product/component/image_format/image_svg.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../core/constant/enum/supported_languages_enum.dart';
import '../../../core/init/language/locale_keys.g.dart';

class SearchVoiceTextFormField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final double? width;
  final TextEditingController? controller;
  SearchVoiceTextFormField({
    Key? key,
    this.width,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  State<SearchVoiceTextFormField> createState() =>
      _SearchVoiceTextFormFieldState();
}

class _SearchVoiceTextFormFieldState extends State<SearchVoiceTextFormField> {
  bool _isListening = false;
  String? _currentLocaleId;
  final SpeechToText speech = SpeechToText();

  void setLanguage() {
    if (context.locale.languageCode ==
        SupportedLanguages.TR.name.toLowerCase()) {
      _currentLocaleId = 'tr-TR';
      print(_currentLocaleId);
    } else if (context.locale.languageCode ==
        SupportedLanguages.EN.name.toLowerCase()) {
      _currentLocaleId = 'en-GB';
      print(_currentLocaleId);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _listen() async {
    if (!_isListening) {
      await speech.initialize(
        onStatus: (val) {
          if (val == 'done' || val == 'notListening') {
            setState(() {
              _isListening = false;
            });
          }
          print('onStatus: $val');
        },
        onError: (val) {
          if (val.errorMsg.isNotEmpty) {
            setState(() {
              _isListening = false;
            });
          }
          print('onError: ${val.errorMsg}');
        },
      ).then((value) {
        setState(() => _isListening = true);
        speech.listen(
          localeId: _currentLocaleId,
          listenFor: const Duration(seconds: 10),
          pauseFor: const Duration(seconds: 4),
          cancelOnError: true,
          listenMode: ListenMode.confirmation,
          onResult: (val) => setState(() {
            widget.controller?.text = val.recognizedWords;
            print(val.recognizedWords);
          }),
        );
        return true;
      });
    } else {
      setState(() => _isListening = false);
      speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    setLanguage();
    return Container(
      width: widget.width ?? context.screenWidth / 1.2,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: ColorConstants.instance.roboticgods.withOpacity(0.9),
            width: 1.0,
            style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        onChanged: widget.onChanged,
        controller: widget.controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: ImageSvg(
              path: ImagePath.searchh.path,
              color: ColorConstants.instance.russianViolet),
          hintText: LocaleKeys.search.locale,
          hintStyle: TextStyle(
              fontSize: 14,
              color: ColorConstants.instance.roboticgods,
              fontWeight: FontWeight.w400),
          suffixIconConstraints: const BoxConstraints(maxHeight: 30),
          suffixIcon: Padding(
            padding: context.paddingLowRightLow,
            child: AvatarGlow(
              endRadius: 25,
              showTwoGlows: true,
              glowColor: ColorConstants.instance.brightNavyBlue,
              animate: _isListening,
              child: InkWell(
                onTap: _listen,
                child: ImageSvg(
                  path: ImagePath.microphone.path,
                  color: ColorConstants.instance.russianViolet,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
