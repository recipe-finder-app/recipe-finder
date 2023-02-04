import 'package:flutter/material.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/widget_core/text_field/standard_text_formfield.dart';

import '../../../core/constant/enum/image_path_enum.dart';
import '../../widget_core/image_format/image_svg.dart';

class UserTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  const UserTextFormField({Key? key, required this.controller, this.hintText}) : super(key: key);

  @override
  State<UserTextFormField> createState() => _UserTextFormFieldState();
}

class _UserTextFormFieldState extends State<UserTextFormField> {
  bool? isValid;
  double calculateTextFieldHeight() {
    if (isValid == false) {
      if (context.screenHeightIsLessThan5Inch) {
        return 65;
      } else if (context.screenHeightIsLargerThan9Inch) {
        return 95;
      } else {
        return 75;
      }
    } else {
      if (context.screenHeightIsLessThan5Inch) {
        return 40;
      } else if (context.screenHeightIsLargerThan9Inch) {
        return 70;
      } else {
        return 50;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StandardTextFormField(
      controller: widget.controller,
      height: calculateTextFieldHeight(),
      width: context.screenWidth / 1.2,
      hintText: widget.hintText != null ? widget.hintText : LocaleKeys.userNameOrEmail.locale,
      maxLines: 1,
      prefixIcon: ImageSvg(
        path: ImagePath.user.path,
      ),
      validator: (tfInput) {
        if (tfInput!.isEmpty) {
          setState(() {
            isValid = false;
          });
          return LocaleKeys.dontEmptyThisField.locale;
        } else {
          setState(() {
            isValid = true;
          });
        }
      },
    );
  }
}

/*class UserTextFormField extends StatelessWidget {
  const UserTextFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandardTextFormField(
      height: context.screenHeight < DeviceSizeEnum.inch_5.size
          ? 40
          : context.screenHeight > DeviceSizeEnum.inch_9.size
              ? 70
              : 50,
      width: context.screenWidth / 1.2,
      hintText: 'Enter Username',
      prefixIcon: ImageSvg(
        path: ImagePath.user.path,
      ),
      validator: (tfInput) {
        if (tfInput!.isEmpty) {
          return "Bu Alanı Boş Bırakmayınız!";
        }
        return null;
      },
    );
  }
}*/
