import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';

import '../../../core/constant/enum/supported_languages_enum.dart';
import '../../../core/init/language/language_manager.dart';
import '../../../core/init/language/locale_keys.g.dart';

class LanguagePopupMenuButton extends StatefulWidget {
  final Color? color;
  const LanguagePopupMenuButton({Key? key, this.color}) : super(key: key);

  @override
  State<LanguagePopupMenuButton> createState() =>
      _LanguagePopupMenuButtonState();
}

class _LanguagePopupMenuButtonState extends State<LanguagePopupMenuButton> {
  String? selectedLanguage;
  int selectedLanguageId = 1;
  void changeSelectedLanguage(int? selectedValue) {
    switch (selectedValue) {
      case 1:
        context.setLocale(LanguageManager.instance.enLocale);
        setState(() {
          selectedLanguage = SupportedLanguages.EN.name;
          selectedLanguageId = selectedValue ?? SupportedLanguages.EN.id;
        });
        break;
      case 2:
        context.setLocale(LanguageManager.instance.trLocale);
        setState(() {
          selectedLanguage = SupportedLanguages.TR.name;
          selectedLanguageId = selectedValue ?? SupportedLanguages.TR.id;
        });
        break;
      default:
        context.setLocale(LanguageManager.instance.enLocale);
        setState(() {
          selectedLanguage = SupportedLanguages.EN.name;
          selectedLanguageId = selectedValue ?? SupportedLanguages.EN.id;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: const Offset(0, 0),
      shape: OutlineInputBorder(borderRadius: context.radiusAllCircularMin),
      color: Colors.white.withOpacity(0.8),
      initialValue: selectedLanguageId,
      itemBuilder: (context) => [
        PopupMenuItem(
            textStyle: TextStyle(
                color: selectedLanguageId == SupportedLanguages.EN.id
                    ? ColorConstants.instance.oriolesOrange
                    : Colors.black),
            value: 1,
            child: const Text(
              'EN',
            )),
        PopupMenuItem(
            textStyle: TextStyle(
                color: selectedLanguageId == SupportedLanguages.TR.id
                    ? ColorConstants.instance.oriolesOrange
                    : Colors.black),
            value: 2,
            child: const Text(
              'TR',
            )),
      ],
      onSelected: (int? value) {
        changeSelectedLanguage(value);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            selectedLanguage ?? LocaleKeys.language.locale,
            style: TextStyle(
                color: widget.color ?? ColorConstants.instance.oriolesOrange),
          ),
          Icon(
            Icons.language,
            color: widget.color ?? ColorConstants.instance.oriolesOrange,
          )
        ],
      ),
    );
  }
}

/*
class LanguagePopupMenuButton extends StatefulWidget {
  const LanguagePopupMenuButton({Key? key}) : super(key: key);

  @override
  State<LanguagePopupMenuButton> createState() =>
      _LanguagePopupMenuButtonState();
}

class _LanguagePopupMenuButtonState extends State<LanguagePopupMenuButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      width: 70,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Colors.white.withOpacity(0.9)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: context.radiusAllCircularVeryHigh,
              /*side: BorderSide(
                  color: ColorConstants.instance.oriolesOrange,
                )*/
            ),
          ),
        ),
        icon: ImageSvg(
          path: ImagePath.discover.path,
          color: ColorConstants.instance.oriolesOrange,
          height: 25,
        ),
        label: Text(
          'EN',
          style: TextStyle(color: ColorConstants.instance.oriolesOrange),
        ),
        onPressed: () {},
      ),
    );
  }
}*/
