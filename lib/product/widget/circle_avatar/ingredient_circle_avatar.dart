import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/product/component/image_format/image_svg.dart';
import 'package:recipe_finder/product/model/ingradient_model.dart';

import '../../component/text/locale_text.dart';

class IngredientCircleAvatar extends StatelessWidget {
  final IngredientModel model;
  final Color? color;
  final Widget? iconBottomWidget;
  final VoidCallback? onPressed;
  const IngredientCircleAvatar(
      {Key? key,
      required this.model,
      this.color,
      this.iconBottomWidget,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          iconBottomWidget != null
              ? Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: color,
                      child: ImageSvg(
                        path: model.imagePath ?? ImagePath.like.path,
                      ),
                    ),
                    iconBottomWidget!,
                  ],
                )
              : CircleAvatar(
                  radius: 32,
                  backgroundColor: color,
                  child: ImageSvg(
                    path: model.imagePath ?? ImagePath.like.path,
                  ),
                ),
          context.veryLowSizedBox,
          FittedBox(
            child: LocaleText(
              fontSize: 12,
              text: model.title,
            ),
          ),
        ],
      ),
    );
  }
}
