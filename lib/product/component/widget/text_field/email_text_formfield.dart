import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_finder/core/component/widget/text_field/standard_text_formfield.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';

import '../../../../core/constant/enum/image_path_enum.dart';

class EmailTextFormField extends StatelessWidget {
  final bool? validator;
  const EmailTextFormField({Key? key, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandardTextFormField(
      height: 55,
      width: context.screenWidth / 1.2,
      hintText: 'Enter Email Address',
      prefixIcon: SvgPicture.asset(
        ImagePath.email.path,
        height: 5,
        width: 5,
        fit: BoxFit.none,
      ),
      validator: (tfInput) {
        if (tfInput!.isEmpty) {
          if (validator == true) {
            return "Bu alanı boş bırakmayın";
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
}
