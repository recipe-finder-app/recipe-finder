import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';

import '../../utils/constant/image_path_enum.dart';
import '../../../core/widget/image_format/image_svg.dart';
import '../../../core/widget/text_field/standard_text_formfield.dart';

class EmailTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final bool? validator;
  final double? width;
  final bool? filled;
  final String? hintText;
  final String? labelText;
  final bool? upLabel;
  const EmailTextFormField({Key? key, this.validator, required this.controller, this.width, this.filled, this.hintText, this.labelText, this.upLabel}) : super(key: key);

  @override
  State<EmailTextFormField> createState() => _EmailTextFormFieldState();
}

class _EmailTextFormFieldState extends State<EmailTextFormField> {
  bool? isValid;

  @override
  Widget build(BuildContext context) {
    return StandardTextFormField(
      controller: widget.controller,
      width: widget.width,
      hintText: LocaleKeys.emailAddress.locale,
      labelText: widget.labelText,
      upLabel: widget.upLabel,
      maxLines: 1,
      filled: widget.filled,
      prefixIcon: ImageSvg(
        path: ImagePathConstant.email.path,
      ),
      isValid: isValid,
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
