import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/component/image_format/image_svg.dart';
import 'package:recipe_finder/product/component/text/bold_text.dart';
import 'package:recipe_finder/product/component/text/locale_text.dart';
import 'package:recipe_finder/product/model/recipe_model.dart';
import 'package:recipe_finder/product/widget/container/transparent_circular_bacground.dart';

class LikesRecipeCard extends StatelessWidget {
  final RecipeModel model;
  final VoidCallback? recipeOnPressed;
  final VoidCallback? addToBasketOnPressed;
  final VoidCallback? likeIconOnPressed;
  const LikesRecipeCard(
      {Key? key,
      this.recipeOnPressed,
      this.addToBasketOnPressed,
      required this.model,
      this.likeIconOnPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 5,
          child: InkWell(
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
          ),
        ),
        Flexible(
          flex: 1,
          child: GestureDetector(
            onTap: addToBasketOnPressed,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: context.radiusBottomCircularMin,
                  color: ColorConstants.instance.white,
                  border:
                      Border.all(color: ColorConstants.instance.oriolesOrange)),
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ImageSvg(
                      path: ImagePath.basket.path,
                      height: 20,
                      width: 20,
                    ),
                    context.veryLowSizedBoxWidth,
                    LocaleText(
                      textAlign: TextAlign.center,
                      text: LocaleKeys.addToBasket,
                      style: TextStyle(
                          color: ColorConstants.instance.oriolesOrange),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Container recipeImage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              model.imagePath,
            )),
        borderRadius: context.radiusTopCircularMin,
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0, 0, 0.6, 1],
            colors: [
              ColorConstants.instance.oriolesOrange,
              Colors.transparent,
              Colors.transparent,
              ColorConstants.instance.oriolesOrange,
            ],
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
          child: TransparentCircularBackground(
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
