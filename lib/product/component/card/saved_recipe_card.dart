import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/feature/likes_page/model/saved_recipe_model.dart';
import 'package:recipe_finder/product/component/image_format/image_svg.dart';
import 'package:recipe_finder/product/component/text/bold_text.dart';
import 'package:recipe_finder/product/component/text/locale_text.dart';

class SavedRecipeCard extends StatelessWidget {
  final SavedRecipeModel model;
  final VoidCallback? recipeOnPressed;
  final VoidCallback? addToBasketOnPressed;
  const SavedRecipeCard(
      {Key? key,
      this.recipeOnPressed,
      this.addToBasketOnPressed,
      required this.model})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 5,
          child: GestureDetector(
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
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      textAlign: TextAlign.start,
                      fontSize: 12,
                      maxLines: 4,
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
                  borderRadius: context.radiusBottomCircularMedium,
                  color: Colors.white,
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
        borderRadius: context.radiusTopCircularMedium,
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
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent.withOpacity(0.2),
              ),
            ),
            ImageSvg(
              path: ImagePath.likeWhite.path,
              height: 20,
              width: 20,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
