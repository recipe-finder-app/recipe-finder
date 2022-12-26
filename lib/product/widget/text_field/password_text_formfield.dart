import 'package:flutter/material.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/product/widget_core/image_format/image_svg.dart';
import 'package:recipe_finder/product/widget_core/text_field/standard_text_formfield.dart';

import '../../../core/constant/enum/device_size_enum.dart';
import '../../../core/constant/enum/image_path_enum.dart';
import '../../../core/init/language/locale_keys.g.dart';

class PasswordTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;

  const PasswordTextFormField({
    Key? key,
    this.controller,
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
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            showPassword = !showPassword;
          });
        },
        child: Padding(
          padding: EdgeInsets.only(right: context.normalValue),
          child: Icon(
              showPassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Colors.black87),
        ),
      ),
      validator: (tfInput) {
        if (tfInput!.isEmpty) {
          setState(() {
            isValid = false;
          });
          return "Bu Alanı Boş Bırakmayınız!";
        } else {
          setState(() {
            isValid = true;
          });
        }
      },
    );
  }
}
