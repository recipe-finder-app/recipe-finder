import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_finder/core/component/widget/text_field/standard_text_formfield.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';

import '../../../../core/constant/enum/image_path_enum.dart';

class UserTextFormField extends StatelessWidget {
  const UserTextFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandardTextFormField(
      height: 55,
      width: context.screenWidth / 1.2,
      hintText: 'Enter Username',
      prefixIcon: SvgPicture.asset(
        ImagePath.user.path,
        height: 5,
        width: 5,
        fit: BoxFit.none,
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
