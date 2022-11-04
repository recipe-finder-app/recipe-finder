import 'package:flutter/material.dart';
import 'package:recipe_finder/core/component/widget/text_field/standard_text_formfield.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';

import '../../../../core/component/widget/svg_picture/image_svg.dart';
import '../../../../core/constant/enum/device_size_enum.dart';
import '../../../../core/constant/enum/image_path_enum.dart';

class UserTextFormField extends StatelessWidget {
  const UserTextFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandardTextFormField(
      height: context.screenHeight < DeviceSizeEnum.inch_5.size
          ? 40
          : context.screenHeight > DeviceSizeEnum.inch_9.size
              ? 70
              : 50,
      width: context.screenWidth / 1.2,
      hintText: 'Enter Username',
      prefixIcon: ImageSvg(
        path: ImagePath.user.path,
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
