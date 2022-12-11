import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';

class TinderCard extends StatelessWidget {
  const TinderCard({
    required this.name,
    required this.assetPath,
    super.key,
  });

  final String name;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: context.cardhighValue,
          width: context.cardValueWidth,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(assetPath),
              fit: BoxFit.cover,
            ),
            borderRadius: context.radiusAllCircularMedium,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: context.radiusAllCircularMedium,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0, 0, 0.4, 1],
                colors: [
                  ColorConstants.instance.russianViolet,
                  Colors.transparent,
                  Colors.transparent,
                  ColorConstants.instance.russianViolet,
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: context.cardValueWidth,
          child: Padding(
            padding: context.paddingNormalOnlyTop,
            child: Text(
              name,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
