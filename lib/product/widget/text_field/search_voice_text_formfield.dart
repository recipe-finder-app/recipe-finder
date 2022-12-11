import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/product/component/image_format/image_svg.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SearchVoiceTextFormField extends StatefulWidget {
  final VoidCallback? onChanged;
  final double width;
  final TextEditingController controller;
  const SearchVoiceTextFormField(
      {Key? key, required this.width, this.onChanged, required this.controller})
      : super(key: key);

  @override
  State<SearchVoiceTextFormField> createState() =>
      _SearchVoiceTextFormFieldState();
}

class _SearchVoiceTextFormFieldState extends State<SearchVoiceTextFormField> {
  bool _hasSpeech = false;
  String _currentLocaleId = '';
  List<LocaleName> _localeNames = [];
  bool _isListening = false;
  final SpeechToText speech = SpeechToText();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _listen() async {
    if (!_isListening) {
      await speech
          .initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      )
          .then((value) {
        if (value == true) {
          setState(() => _isListening = true);
          speech.listen(
            onResult: (val) => setState(() {
              widget.controller.text = val.recognizedWords;
            }),
          );
          return true;
        } else {
          return false;
        }
      });
    } else {
      setState(() => _isListening = false);
      speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        color: ColorConstants.instance.white,
        border: Border.all(
            color: ColorConstants.instance.roboticgods.withOpacity(0.9),
            width: 2.0,
            style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: ImageSvg(
              path: ImagePath.searchh.path,
              color: ColorConstants.instance.russianViolet),
          hintText: 'Search',
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
