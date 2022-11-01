import 'package:flutter/material.dart';

import '../../../constant/design/color_constant.dart';

class CircularProgressIndicatorBlue extends StatelessWidget {
  const CircularProgressIndicatorBlue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircularProgressIndicator(
            strokeWidth: 6,
            color: ColorConstants.instance.brightNavyBlue,
          ),
        ]),
      ],
    );
  }
}
