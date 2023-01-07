import 'package:flutter/material.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/product/widget_core/text_field/standard_text_formfield.dart';

import '../../../core/constant/enum/device_size_enum.dart';
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

  @override
  Widget build(BuildContext context) {
    return StandardTextFormField(
      controller: widget.controller,
      hintText: LocaleKeys.password.locale,
      maxLines: 1,
      keyboardType: TextInputType.visiblePassword,
      height: context.screenHeight < DeviceSizeEnum.inch_5.size
          ? isValid == false
              ? 70
              : 40
          : context.screenHeight > DeviceSizeEnum.inch_9.size
              ? isValid == false
                  ? 100
                  : 70
              : isValid == false
                  ? 80
                  : 50,
      width: context.screenWidth / 1.2,
      obscureText: !showPassword,
      prefixIcon: ImageSvg(
        path: ImagePath.password.path,
      ),
      suffixIcon: Padding(
        padding: EdgeInsets.only(right: context.normalValue),
        child: IconButton(
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
