import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/product/utils/constant/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/extension/int_extension.dart';
import 'package:recipe_finder/product/model/ingredient/ingredient_model.dart';

import '../../../core/widget/image_format/image_svg.dart';
import '../../../core/widget/text/locale_text.dart';

class IngredientCircleAvatar extends StatelessWidget {
  final IngredientModel model;
  final Color? color;
  final Widget? iconTopWidget;
  final VoidCallback? onPressed;
  final bool? showText;
  final double? textFontSize;
  final String? textRowText;
  final Color? textColor;
  final FontWeight? textFontWeight;
  const IngredientCircleAvatar({
    Key? key,
    required this.model,
    this.color,
    this.iconTopWidget,
    this.onPressed,
    this.showText,
    this.textFontSize,
    this.textRowText,
    this.textColor,
    this.textFontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: context.radiusAllCircularVeryHigh,
      child: Column(
        children: [
          iconTopWidget != null
              ? Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: model.color?.toColor ?? color,
                      child: ImageSvg(
                        path: model.imagePath ?? ImagePathConstant.like.path,
                      ),
                    ),
                    iconTopWidget!,
                  ],
                )
              : CircleAvatar(
                  radius: 32,
                  backgroundColor: model.color?.toColor ?? color,
                  child: ImageSvg(
                    path: model.imagePath ?? ImagePathConstant.like.path,
                  ),
                ),
          context.veryLowSizedBox,
          showText == false
              ? const SizedBox(
                  height: 0,
                  width: 0,
                )
              : textRowText != null
                  ? FittedBox(
                      child: LocaleText(
                        locale: context.locale,
                        fontSize: textFontSize ?? 12,
                        text: '$textRowText ${model.nameEN}',
                        color: textColor ?? ColorConstants.instance.roboticgods,
                        fontWeight: textFontWeight,
                      ),
                    )
                  : FittedBox(
                      child: LocaleText(
                        locale: context.locale,
                        fontSize: textFontSize ?? 12,
                        text: model.nameEN!,
                        color: textColor ?? ColorConstants.instance.roboticgods,
                        fontWeight: textFontWeight,
                      ),
                    ),
        ],
      ),
    );
  }
}
