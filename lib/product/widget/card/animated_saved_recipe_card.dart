import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/model/recipe/recipe_model.dart';
import 'package:recipe_finder/product/widget/container/circular_bacground.dart';

import '../../../core/widget/image_format/image_svg.dart';
import '../../../core/widget/text/bold_text.dart';
import '../../../core/widget/text/locale_text.dart';
import '../alert_dialog/question_alert_dialog.dart';

class AnimatedLikesRecipeCard extends StatefulWidget {
  final RecipeModel model;
  final VoidCallback? onPressed;
  final VoidCallback? addToBasketOnPressed;
  final VoidCallback? likeIconOnPressedYes;
  const AnimatedLikesRecipeCard({Key? key, this.onPressed, this.addToBasketOnPressed, required this.model, this.likeIconOnPressedYes}) : super(key: key);

  @override
  State<AnimatedLikesRecipeCard> createState() => _AnimatedLikesRecipeCardState();
}

class _AnimatedLikesRecipeCardState extends State<AnimatedLikesRecipeCard> with TickerProviderStateMixin {
  late AnimationController _animationController;
  // late AnimationController _animationControllerStart;
  // late Animation<double> _animationStart;
  late Animation<double> _animationDouble;
  late Animation<Offset> _animationOffset;

  /*void _startAnimation() {
    _animationControllerStart.forward().then((value) => _animationControllerStart.dispose());
  }*/

  void _setAnimation() {
    /*  _animationControllerStart = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );*/
    /* _animationStart = Tween<double>(begin: 0, end: 1).animate(_animationControllerStart);*/
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animationDouble = Tween<double>(begin: 1, end: 0).animate(_animationController);
    _animationOffset = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -1)).animate(_animationController);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setAnimation();
    // _startAnimation();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
    //_animationControllerStart.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationDouble,
      child: SlideTransition(
        position: _animationOffset,
        child: Column(
          key: widget.key,
          children: [
            Flexible(
              flex: 5,
              child: InkWell(
                onTap: widget.onPressed,
                child: Stack(
                  children: [
                    recipeImage(context),
                    likeImage(context),
                    Padding(
                      padding: context.paddingLowAll,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: BoldText(
                          text: widget.model.title!,
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
                onTap: widget.addToBasketOnPressed,
                child: Container(
                  decoration: BoxDecoration(borderRadius: context.radiusBottomCircularMin, color: ColorConstants.instance.white, border: Border.all(color: ColorConstants.instance.oriolesOrange)),
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
                          style: TextStyle(color: ColorConstants.instance.oriolesOrange),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container recipeImage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              widget.model.imagePath ?? '',
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
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return QuestionAlertDialog(
                    explanation: LocaleKeys.deleteSavedRecipeQuestion,
                    onPressedYes: () {
                      _animationController.forward().then((value) => widget.likeIconOnPressedYes?.call()).then((value) => _animationController.reset());
                    },
                  );
                });
          },
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
