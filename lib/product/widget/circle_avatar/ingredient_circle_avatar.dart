import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/product/utils/constant/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import '../../../core/init/language/language_manager.dart';
import '../../../core/widget/text/locale_text.dart';
import '../../model/ingredient_quantity/ingredient_quantity.dart';

class IngredientCircleAvatar extends StatelessWidget {
  final IngredientQuantity model;
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
     String title = (context.locale == LanguageManager.instance.trLocale ? model.nameTR : model.nameEN)!;
     
    return InkWell(
      onTap: onPressed,
      borderRadius: context.radiusAllCircularVeryHigh,
      child: Column(
        children: [
          iconTopWidget != null
              ? Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    buildCircleAvatar(),
                      iconTopWidget!,
                  ]
                    ) 
                     : buildCircleAvatar(),
             
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
                        text: '$textRowText ${title}',
                        color: textColor ?? ColorConstants.instance.roboticgods,
                        fontWeight: textFontWeight,
                      ),
                    )
                  : FittedBox(
                      child: LocaleText(
                        locale: context.locale,
                        fontSize: textFontSize ?? 12,
                        text: title,
                        color: textColor ?? ColorConstants.instance.roboticgods,
                        fontWeight: textFontWeight,
                      ),
                    ),
          ],
      ),
    );
  }

  CircleAvatar buildCircleAvatar() {
    return CircleAvatar(
                    radius: 32,
                    backgroundColor: model.color?.toColor ?? color,
                    child: (model.imageUrl == null || 
                    (model.imageUrl!=null && model.imageUrl!.isEmpty))
                    ? SvgPicture.asset(ImagePathConstant.like.path)
                    : SvgPicture.network(model.imageUrl!,placeholderBuilder: (BuildContext context) => SizedBox(height:15,width:15,child:CircularProgressIndicator(color: ColorConstants.instance.oriolesOrange,strokeWidth:2,)),)
                    );
  }
}
