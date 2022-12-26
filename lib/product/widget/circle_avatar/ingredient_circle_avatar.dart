import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/product/model/ingradient_model.dart';
import 'package:recipe_finder/product/widget_core/image_format/image_svg.dart';

import '../../widget_core/text/locale_text.dart';

class IngredientCircleAvatar extends StatelessWidget {
  final IngredientModel model;
  final Color? color;
  final Widget? iconTopWidget;
  final VoidCallback? onPressed;
  final bool? showText;
  const IngredientCircleAvatar({
    Key? key,
    required this.model,
    this.color,
    this.iconTopWidget,
    this.onPressed,
    this.showText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          iconTopWidget != null
              ? Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: model.color ?? color,
                      child: ImageSvg(
                        path: model.imagePath ?? ImagePath.like.path,
                      ),
                    ),
                    iconTopWidget!,
                  ],
                )
              : CircleAvatar(
                  radius: 32,
                  backgroundColor: model.color ?? color,
                  child: ImageSvg(
                    path: model.imagePath ?? ImagePath.like.path,
                  ),
                ),
          context.veryLowSizedBox,
          showText == false
              ? const SizedBox()
              : FittedBox(
                  child: LocaleText(
                      locale: context.locale,
                      fontSize: 12,
                      text: model.title,
                      color: ColorConstants.instance.roboticgods),
                ),
        ],
      ),
    );
  }
}
