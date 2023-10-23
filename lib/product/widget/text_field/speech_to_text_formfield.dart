import 'package:avatar_glow/avatar_glow.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/product/utils/constant/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../utils/enum/supported_languages_enum.dart';
import '../../../core/widget/image_format/image_svg.dart';
import '../../../core/widget/text_field/standard_text_formfield.dart';

class SpeechToTextFormField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final double? width;
  final TextEditingController controller;
  final VoidCallback? onPressedClear;
  final bool? borderEnable;
  final bool? filled;
  final Color? filledColor;
  final String? hintText;
  final Widget? icon;
  const SpeechToTextFormField({Key? key, this.width, this.onChanged, required this.controller, this.onPressedClear, this.borderEnable, this.filled, this.filledColor, this.hintText, this.icon}) : super(key: key);

  @override
  State<SpeechToTextFormField> createState() => _SpeechToTextFormFieldState();
}

class _SpeechToTextFormFieldState extends State<SpeechToTextFormField> {
  bool _isListening = false;
  String? _currentLocaleId;
  final SpeechToText speech = SpeechToText();

  void setLanguage() {
    if (context.locale.languageCode == SupportedLanguages.TR.name.toLowerCase()) {
      _currentLocaleId = 'tr-TR';
    } else if (context.locale.languageCode == SupportedLanguages.EN.name.toLowerCase()) {
      _currentLocaleId = 'en-GB';
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
          listenFor: const Duration(seconds: 7),
          pauseFor: const Duration(seconds: 4),
          cancelOnError: true,
          listenMode: ListenMode.confirmation,
          onResult: (val) => setState(() {
            widget.controller.text = val.recognizedWords;
            if (widget.onChanged != null) {
              widget.onChanged!.call(val.recognizedWords);
            }
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
    return StandardTextFormField(
      controller: widget.controller,
      hintText: widget.hintText,
      borderEnable: widget.borderEnable,
      filled: widget.filled,
      filledColor: widget.filledColor,
      prefixIcon: ImageSvg(path: ImagePathConstant.searchh.path, color: ColorConstants.instance.russianViolet),
      suffixIcon: Padding(
        padding: EdgeInsets.only(right: context.lowValue),
        child: AvatarGlow(
          endRadius: 25,
          showTwoGlows: true,
          glowColor: Colors.blue,
          animate: _isListening,
          child: IconButton(
            onPressed: _listen,
            icon: ImageSvg(
              path: ImagePathConstant.microphone.path,
            ),
          ),
        ),
      ),
      onPressedClear: widget.onPressedClear,
      onChanged: (data) {
        if (widget.onChanged != null) {
          widget.onChanged!.call(data.toString());
        }
      },
    );
  }
}
