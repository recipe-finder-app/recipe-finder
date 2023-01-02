import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';

import '../../model/recipe_model.dart';

class TinderCard extends StatelessWidget {
  const TinderCard({
    super.key,
    required this.model,
    this.recipeOnPressed,
  });

  final RecipeModel model;
  final VoidCallback? recipeOnPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: recipeOnPressed,
      child: Stack(
        children: [
          Container(
            height: context.cardhighValue,
            width: context.cardValueWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(model.imagePath ?? ''),
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
                model.title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: ColorConstants.instance.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
