import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/product/model/recipe_model.dart';
import 'package:recipe_finder/product/widget/container/circular_bacground.dart';
import 'package:recipe_finder/product/widget_core/text/bold_text.dart';

class DiscoverCard extends StatelessWidget {
  final RecipeModel model;
  final VoidCallback? recipeOnPressed;
  final VoidCallback? addToBasketOnPressed;
  final VoidCallback? likeIconOnPressed;
  final double? width;
  const DiscoverCard(
      {Key? key,
      this.recipeOnPressed,
      this.addToBasketOnPressed,
      required this.model,
      this.likeIconOnPressed,
      this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: recipeOnPressed,
      child: Stack(
        children: [
          recipeImage(context),
          likeImage(context),
          Padding(
            padding: context.paddingLowAll,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: BoldText(
                text: model.title,
                textColor: ColorConstants.instance.white,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.start,
                fontSize: 12,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }

  SizedBox recipeImage(BuildContext context) {
    return SizedBox(
      width: width ?? context.screenWidth / 1.3,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                model.imagePath,
              )),
          borderRadius: context.radiusAllCircularMin,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: context.radiusBottomCircularMin,
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0, 0.6, 1],
              colors: [
                Colors.black,
                Colors.transparent,
                Colors.transparent,
                Colors.black,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding likeImage(BuildContext context) {
    return Padding(
      padding: context.paddingNormalAll,
      child: Align(
        alignment: Alignment.topRight,
        child: InkWell(
          onTap: likeIconOnPressed,
          child: CircularBackground(
            circleHeight: 35,
            circleWidth: 35,
            child: Icon(
              Icons.favorite,
              color: ColorConstants.instance.white,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
