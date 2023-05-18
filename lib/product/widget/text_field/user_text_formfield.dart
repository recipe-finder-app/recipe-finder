import 'package:flutter/material.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';

import '../../../core/constant/enum/image_path_enum.dart';
import '../../../core/widget/image_format/image_svg.dart';
import '../../../core/widget/text_field/standard_text_formfield.dart';

class UserTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final bool? filled;
  final double? width;
  final bool? isValid;
  final bool? canBeEmpty;
  final StringFunction? validator;
  const UserTextFormField({Key? key, required this.controller, this.hintText, this.filled, this.width, this.canBeEmpty, this.validator, this.isValid}) : super(key: key);

  @override
  State<UserTextFormField> createState() => _UserTextFormFieldState();
}

class _UserTextFormFieldState extends State<UserTextFormField> {
  @override
  Widget build(BuildContext context) {
    return StandardTextFormField(
      controller: widget.controller,
      width: widget.width,
      hintText: widget.hintText ?? LocaleKeys.userNameOrEmail.locale,
      maxLines: 1,
      filled: widget.filled,
      prefixIcon: ImageSvg(
        path: ImagePath.user.path,
      ),
      isValid: widget.isValid,
      canBeEmpty: widget.canBeEmpty,
      validator: widget.validator,
    );
  }
}
