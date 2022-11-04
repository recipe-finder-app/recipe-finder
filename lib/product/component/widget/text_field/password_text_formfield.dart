import 'package:flutter/material.dart';
import 'package:recipe_finder/core/component/widget/svg_picture/image_svg.dart';
import 'package:recipe_finder/core/component/widget/text_field/standard_text_formfield.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';

import '../../../../core/constant/enum/device_size_enum.dart';
import '../../../../core/constant/enum/image_path_enum.dart';

class PasswordTextFormField extends StatefulWidget {
  final TextEditingController? tfController;
  final String? hintText;

  const PasswordTextFormField({
    Key? key,
    this.tfController,
    this.hintText,
  }) : super(key: key);

  @override
  _PasswordTextFormFieldState createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return StandardTextFormField(
      hintText: 'Enter Password',
      maxLines: 1,
      keyboardType: TextInputType.visiblePassword,
      height: context.screenHeight < DeviceSizeEnum.inch_5.size
          ? 40
          : context.screenHeight > DeviceSizeEnum.inch_9.size
              ? 70
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
        child: Icon(
            showPassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: Colors.black87),
      ),
      validator: (tfInput) {
        if (tfInput!.isEmpty) {
          return "Bu Alanı Boş Bırakmayınız!";
        }
        return null;
      },
    );
  }
}
