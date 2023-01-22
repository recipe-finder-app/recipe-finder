import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/widget_core/image_format/image_svg.dart';
import 'package:recipe_finder/product/widget_core/text_field/standard_text_formfield.dart';

import '../../../core/constant/enum/image_path_enum.dart';

class EmailTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final bool? validator;
  const EmailTextFormField({Key? key, this.validator, required this.controller}) : super(key: key);

  @override
  State<EmailTextFormField> createState() => _EmailTextFormFieldState();
}

class _EmailTextFormFieldState extends State<EmailTextFormField> {
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
      hintText: LocaleKeys.emailAddress.locale,
      maxLines: 1,
      prefixIcon: ImageSvg(
        path: ImagePath.email.path,
      ),
      validator: (tfInput) {
        if (tfInput!.isEmpty) {
          if (widget.validator == true) {
            setState(() {
              isValid = false;
            });
            return LocaleKeys.dontEmptyThisField.locale;
          } else {
            return null;
          }
        } else if (EmailValidator.validate(tfInput) == false) {
          setState(() {
            isValid = false;
          });
          return LocaleKeys.enterValidEmailAddress.locale;
        } else {
          setState(() {
            isValid = true;
          });
        }
      },
    );
  }
}

/*class EmailTextFormField extends StatelessWidget {
  final bool? validator;
  const EmailTextFormField({Key? key, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandardTextFormField(
      height: context.screenHeight < DeviceSizeEnum.inch_5.size
          ? 40
          : context.screenHeight > DeviceSizeEnum.inch_9.size
              ? 70
              : 50,
      width: context.screenWidth / 1.2,
      hintText: 'Enter Email Address',
      prefixIcon: ImageSvg(
        path: ImagePath.email.path,
      ),
      validator: (tfInput) {
        if (tfInput!.isEmpty) {
          if (validator == true) {
            return "Bu alanı boş bırakmayınız!";
          } else {
            return null;
          }
        } else if (EmailValidator.validate(tfInput) == false) {
          return "Geçerli bir email girin!";
        }
        return null;
      },
    );
  }
}*/
