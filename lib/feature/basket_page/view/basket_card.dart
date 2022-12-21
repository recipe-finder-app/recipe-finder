import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/product/model/recipe_model.dart';

import '../../../feature/likes_page/model/like_recipe_model.dart';

class BasketRecipeCard extends StatelessWidget {
  final RecipeModel model;
  final VoidCallback? cardOnPressed;
  
  final VoidCallback? removeIconOnPressed;
  const BasketRecipeCard(
      {Key? key,
      this.cardOnPressed,
    
      required this.model,
      this.removeIconOnPressed})
      : super(key: key);
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
        height: context.normalhighValue,
        width: context.veryWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                model.imagePath,
              )),
          // border: Border.all(
          //     color: Colors.black,
          //     width: 5.0,
          //     style: BorderStyle.solid),
          borderRadius: context.radiusAllCircularMedium,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: context.radiusAllCircularMedium,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0, 0.2, 1],
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
    );
  }

  Widget removeIcon(BuildContext context) {
    return Padding(
      padding: context.paddingVeryEdges,
      child: CircleAvatar(
        radius: 16,
        backgroundColor: Color.fromARGB(255, 247, 102, 100),
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
