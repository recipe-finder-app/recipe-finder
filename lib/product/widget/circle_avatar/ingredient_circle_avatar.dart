import 'package:flutter/material.dart';
import 'package:recipe_finder/product/component/image_format/image_svg.dart';

import '../../component/text/locale_text.dart';

class IngradientCircleAvatar extends StatelessWidget {
  final String imagePath;
  final String? text;
  final Color? color;
  final Widget? widgetOnIcon;
  const IngradientCircleAvatar(
      {Key? key,
      required this.imagePath,
      this.text,
      this.color,
      this.widgetOnIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        widgetOnIcon != null
            ? Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: color,
                    child: ImageSvg(
                      path: imagePath,
                    ),
                  ),
                  widgetOnIcon!,
                ],
              )
            : CircleAvatar(
                radius: 32,
                backgroundColor: color,
                child: ImageSvg(
                  path: imagePath,
                ),
              ),
        text != null
            ? LocaleText(
                text: text!,
              )
            : const Center(),
      ],
    );
  }
}
