import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_finder/core/component/widget/text_field/standard_text_formfield.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';

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
      height: 55,
      width: context.screenWidth / 1.2,
      obscureText: !showPassword,
      prefixIcon: SvgPicture.asset(
        ImagePath.password.path,
        height: 5,
        width: 5,
        fit: BoxFit.none,
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
