import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/product/model/recipe_model.dart';

class BasketRecipeCard extends StatelessWidget {
  final RecipeModel model;
  final VoidCallback? cardOnPressed;
  final BoxBorder? border;
  final Gradient? gradient;
  final double? width;
  final double? height;

  final VoidCallback? removeIconOnPressed;
  const BasketRecipeCard({
    Key? key,
    this.cardOnPressed,
    required this.model,
    this.removeIconOnPressed,
    required this.border,
    required this.gradient,
    required this.height, this.width,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: cardOnPressed,
      child: Stack(
        children: [
          imageCard(context),
          removeIcon(context),
          Padding(
            padding: context.paddingHighOnlyTopLeft,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                model.title,
                //  overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: ColorConstants.instance.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageCard(BuildContext context) {
    return Padding(
      padding: context.paddingLowRight,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                model.imagePath,
              )),
          border: border,
          borderRadius: context.radiusAllCircularMedium,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: context.radiusAllCircularMedium,
            gradient: gradient,
          ),
        ),
      ),
    );
  }

  Widget removeIcon(BuildContext context) {
    return Padding(
      padding: context.paddingVeryEdges,
      child: CircleAvatar(
        radius: 16,
        backgroundColor: ColorConstants.instance.oriolesOrange.withOpacity(0.8),
        child: InkWell(
          onTap: removeIconOnPressed,
          child: Icon(
            Icons.remove,
            size: 30,
            color: ColorConstants.instance.white,
          ),
        ),
      ),
    );
  }
}
