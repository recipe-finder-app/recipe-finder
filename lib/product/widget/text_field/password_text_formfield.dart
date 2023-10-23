import 'package:flutter/material.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';

import '../../utils/constant/image_path_enum.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../core/widget/image_format/image_svg.dart';
import '../../../core/widget/text_field/standard_text_formfield.dart';

class PasswordTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final bool? filled;
  final double? width;
  final bool? isValid;
  final bool? canBeEmpty;
  final StringFunction? validator;
  const PasswordTextFormField({Key? key, required this.controller, this.hintText, this.filled, this.width, this.canBeEmpty, this.validator, this.isValid}) : super(key: key);

  @override
  _PasswordTextFormFieldState createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return StandardTextFormField(
      controller: widget.controller,
      hintText: LocaleKeys.password.locale,
      filled: widget.filled,
      maxLines: 1,
      keyboardType: TextInputType.visiblePassword,
      width: widget.width,
      obscureText: !showPassword,
      prefixIcon: ImageSvg(
        path: ImagePathConstant.password.path,
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
      isValid: widget.isValid,
      canBeEmpty: widget.canBeEmpty,
      validator: widget.validator,
    );
  }
}
