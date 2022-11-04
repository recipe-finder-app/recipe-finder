import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/core/component/widget/svg_picture/image_svg.dart';
import 'package:recipe_finder/core/component/widget/text_field/standard_text_formfield.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';

import '../../../../core/constant/enum/device_size_enum.dart';
import '../../../../core/constant/enum/image_path_enum.dart';

class EmailTextFormField extends StatelessWidget {
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
