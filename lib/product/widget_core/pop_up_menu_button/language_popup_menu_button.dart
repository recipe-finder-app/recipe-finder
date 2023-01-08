import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';

import '../../../core/constant/enum/supported_languages_enum.dart';
import '../../../core/init/language/language_manager.dart';
import '../image_format/image_svg.dart';

class LanguagePopupMenuButton extends StatefulWidget {
  final Color? color;
  const LanguagePopupMenuButton({Key? key, this.color}) : super(key: key);

  @override
  State<LanguagePopupMenuButton> createState() => _LanguagePopupMenuButtonState();
}

class _LanguagePopupMenuButtonState extends State<LanguagePopupMenuButton> {
  String? selectedLanguage;
  int? selectedLanguageId;
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
      offset: selectedLanguageId == 2 ? Offset(0, 50) : Offset(0, 0),
      shape: OutlineInputBorder(borderRadius: context.radiusAllCircularMin),
      position: PopupMenuPosition.under,
      color: Colors.white.withOpacity(0.8),
      initialValue: selectedLanguageId ?? 1,
      itemBuilder: (context) => [
        PopupMenuItem(
            textStyle: TextStyle(color: context.locale.languageCode == SupportedLanguages.EN.name.toLowerCase() ? ColorConstants.instance.oriolesOrange : Colors.black),
            value: 1,
            child: const Text(
              'English (EN)',
            )),
        PopupMenuItem(
            textStyle: TextStyle(color: context.locale.languageCode == SupportedLanguages.TR.name.toLowerCase() ? ColorConstants.instance.oriolesOrange : Colors.black),
            value: 2,
            child: const Text(
              'Türkçe (TR)',
            )),
      ],
      onSelected: (int? value) {
        changeSelectedLanguage(value);
      },
      child: Container(
        height: 36,
        width: 65,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: context.radiusAllCircularHigh,
          border: Border.all(
            color: ColorConstants.instance.oriolesOrange,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageSvg(
              color: widget.color ?? ColorConstants.instance.oriolesOrange,
              path: ImagePath.discover.path,
            ),
            Text(
              selectedLanguage ?? context.locale.languageCode.toUpperCase(),
              style: TextStyle(color: widget.color ?? ColorConstants.instance.oriolesOrange),
            ),
          ],
        ),
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
