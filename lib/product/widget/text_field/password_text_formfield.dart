import 'package:flutter/material.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/product/widget_core/text_field/standard_text_formfield.dart';

import '../../../core/constant/enum/image_path_enum.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../widget_core/image_format/image_svg.dart';

class PasswordTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;

  const PasswordTextFormField({
    Key? key,
    required this.controller,
    this.hintText,
  }) : super(key: key);

  @override
  _PasswordTextFormFieldState createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool showPassword = false;
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
      hintText: LocaleKeys.password.locale,
      maxLines: 1,
      keyboardType: TextInputType.visiblePassword,
      height: calculateTextFieldHeight(),
      width: context.screenWidth / 1.2,
      obscureText: !showPassword,
      prefixIcon: ImageSvg(
        path: ImagePath.password.path,
      ),
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            showPassword = !showPassword;
          });
        },
        icon: Icon(
          showPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: Colors.black87,
        ),
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
