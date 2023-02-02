import 'package:flutter/material.dart';

import '../../../core/constant/design/color_constant.dart';

class CircularProgressIndicatorBlue extends StatelessWidget {
  final Color? color;
  final double? strokeWidth;
  const CircularProgressIndicatorBlue({Key? key, this.color, this.strokeWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircularProgressIndicator(
            strokeWidth: strokeWidth == null ? 6 : strokeWidth!,
            color: color == null ? ColorConstants.instance.brightNavyBlue : color,
          ),
        ]),
      ],
    );
  }
}
