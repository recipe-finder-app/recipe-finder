import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';

import '../../../core/constant/enum/device_size_enum.dart';
import '../../widget_core/text/locale_text.dart';

class RecipeFabButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final VoidCallback? onPressed;
  final double? width;
  final TextDirection? textDirection;
  final Object? heroTag;
  const RecipeFabButton({Key? key, required this.text, this.color, this.textColor, this.onPressed, this.width, this.textDirection, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight < DeviceSizeEnum.inch_5.size
          ? 40
          : context.screenHeight > DeviceSizeEnum.inch_9.size
              ? 70
              : 50,
      width: width ?? context.screenWidth / 1.2,
      child: Directionality(
        textDirection: textDirection ?? TextDirection.ltr,
        child: FloatingActionButton(
            heroTag: heroTag,
            elevation: 5,
            highlightElevation: 5,
            focusElevation: 5,
            hoverElevation: 5,
            disabledElevation: 5,
            backgroundColor: color ?? ColorConstants.instance.russianViolet,
            shape: RoundedRectangleBorder(
                borderRadius: context.radiusAllCircularMedium,
                side: const BorderSide(
                  color: Colors.transparent,
                )),
            onPressed: onPressed,
            child: FittedBox(
              child: LocaleText(textAlign: TextAlign.center, text: text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor ?? Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
            )),
      ),
    );
  }
}
