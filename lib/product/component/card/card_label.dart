import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';

const _labelAngle = math.pi / 2 * 0.2;

class CardLabel extends StatelessWidget {
  const CardLabel._({
    required this.icon,
    required this.angle,
  });

  factory CardLabel.right() {
    return CardLabel._(
      icon: Icon(Icons.favorite, color: ColorConstants.instance.oriolesOrange),
      angle: -_labelAngle,
    );
  }

  factory CardLabel.left() {
    return CardLabel._(
      icon: Icon(
        Icons.close,
        color: ColorConstants.instance.russianViolet,
      ),
      angle: _labelAngle,
    );
  }

  factory CardLabel.up() {
    return CardLabel._(
      icon: Image.asset('asset/png/icon_shop.png'),
      angle: _labelAngle,
    );
  }

  // factory CardLabel.down() {
  //   return const CardLabel._(
  //     color: Colors.white,
  //     label: 'DOWN',
  //     angle: -_labelAngle,
  //     alignment: Alignment(0, -0.75),
  //   );
  // }

  final Widget icon;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Transform.rotate(
        angle: angle,
        child: Container(
            decoration: BoxDecoration(
              color: ColorConstants.instance.white,
              borderRadius: context.radiusAllCircularVeryHigh,
            ),
            padding: context.paddingVeryLowAll,
            child: IconButton(
              icon: icon,
              onPressed: () {},
            )),
      ),
    );
  }
}
