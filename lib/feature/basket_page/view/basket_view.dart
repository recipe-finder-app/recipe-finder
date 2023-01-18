import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/widget/alert_dialog/question_alert_dialog.dart';
import 'package:recipe_finder/product/widget/circle_avatar/ingredient_circle_avatar.dart';
import 'package:recipe_finder/product/widget_core/image_format/image_svg.dart';
import 'package:recipe_finder/product/widget_core/text/locale_text.dart';

import '../../../core/base/view/base_view.dart';
import '../../../product/widget/card/basket_card.dart';
import '../../../product/widget/circle_avatar/amount_ingredient_circle_avatar.dart';
import '../../home_page/cubit/home_cubit.dart';
import '../cubit/basket_cubit.dart';

class BasketView extends StatefulWidget {
  const BasketView({Key? key}) : super(key: key);

  @override
  State<BasketView> createState() => _BasketViewState();
}

class _BasketViewState extends State<BasketView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  void _startAnimation() {
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<BasketCubit>(
        init: (cubitRead) {
          cubitRead.init();
          _animationController = AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 500),
          );
          _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
          _startAnimation();
        },
        dispose: (cubitRead) {
          _animationController.dispose();
        },
        visibleProgress: false,
        onPageBuilder: (BuildContext context, cubitRead, cubitWatch) => Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: context.paddingNormalTopLeftRight,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LocaleText(
                          style: TextStyle(
                            fontSize: 24,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.instance.russianViolet,
                          ),
                          text: LocaleKeys.myBasketList,
                        ),
                        context.lowSizedBox,
                        myBasketListView(context, cubitRead),
                        context.lowSizedBox,
                        LocaleText(
                          text: LocaleKeys.toBuyList,
                          style: TextStyle(
                            fontSize: 24,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.instance.russianViolet,
                          ),
                        ),
                        context.lowSizedBox,
                        cubitRead.selectedCardModel == null ? FadeTransition(opacity: _animation, child: const LocaleText(text: 'Satın alım listesini görmek için yukarıdan kart seçin')) : buildToBuyList(cubitRead),
                        context.lowSizedBox,
                        LocaleText(
                          text: LocaleKeys.myPantry,
                          style: TextStyle(
                            fontSize: 24,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.instance.russianViolet,
                          ),
                        ),
                        context.lowSizedBox,
                        buildGridViewMyPantry(context),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  Widget buildToBuyList(BasketCubit cubitRead) {
    return FadeTransition(
      opacity: _animation,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: cubitRead.selectedCardModel?.ingredients.length,
        itemBuilder: (context, listViewIndex) {
          return Padding(
            padding: EdgeInsets.only(top: context.lowValue, bottom: context.lowValue),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    AmountIngredientCircleAvatar(
                      model: cubitRead.selectedCardModel!.ingredients[listViewIndex],
                    ),
                    context.normalSizedBoxWidth,
                    Padding(
                      padding: context.paddingHighBottom,
                      child: Text(cubitRead.selectedCardModel!.ingredients[listViewIndex].title),
                    ),
                  ],
                ),
                Padding(
                  padding: context.paddingHighBottom,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: ColorConstants.instance.chenille,
                        child: IconButton(
                          icon: Icon(
                            Icons.done,
                            color: ColorConstants.instance.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      context.lowSizedBoxWidth,
                      CircleAvatar(
                          radius: 20,
                          backgroundColor: ColorConstants.instance.oriolesOrange,
                          child: ImageSvg(
                            path: ImagePath.basketShop.path,
                          )),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  SizedBox myBasketListView(BuildContext context, BasketCubit cubitRead) {
    return SizedBox(
      height: context.normalhighValue,
      width: context.screenWidth,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: cubitRead.basketRecipeItems.length,
        itemBuilder: (context, int cardIndex) {
          return BasketRecipeCard(
            borderRadius: cubitRead.selectedColorIndex == cardIndex ? null : context.radiusAllCircularMedium,
            height: cubitRead.selectedColorIndex == cardIndex ? 130 : 120,
            width: cubitRead.selectedColorIndex == cardIndex ? 130 : 120,
            model: cubitRead.basketRecipeItems[cardIndex],
            cardOnPressed: () {
              cubitRead.changeSelectedCardModel(cubitRead.basketRecipeItems[cardIndex]);
              cubitRead.changeSelectedColorIndex(cardIndex);
              _startAnimation();
            },
            removeIconOnPressed: (() {
              showDialog(
                  context: context,
                  builder: (context) {
                    return QuestionAlertDialog(
                      explanation: LocaleKeys.removeCard,
                      onPressedYes: () {
                        cubitRead.deletedItemFromBasketRecipeList(cubitRead.basketRecipeItems[cardIndex]);
                        cubitRead.changeSelectedCardModel(null);
                        cubitRead.changeSelectedColorIndex(null);
                      },
                    );
                  });
            }),
            border: cubitRead.selectedColorIndex == cardIndex ? Border.all(color: cubitRead.selectedCardItemColor(cardIndex), width: 6) : null,
            gradient: cubitRead.selectedColorIndex == cardIndex
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0, 0, 0.2, 4],
                    colors: [
                      cubitRead.selectedCardItemColor(cardIndex),
                      Colors.transparent,
                      Colors.transparent,
                      cubitRead.selectedCardItemColor(cardIndex),
                    ],
                  )
                : LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0, 0, 0.2, 1],
                    colors: [
                      cubitRead.selectedCardItemColor(cardIndex),
                      Colors.transparent,
                      Colors.transparent,
                      cubitRead.selectedCardItemColor(cardIndex),
                    ],
                  ),
          );
        },
      ),
    );
  }

  GridView buildGridViewMyPantry(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: context.read<HomeCubit>().myFrizeItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 0.70, crossAxisSpacing: 30, mainAxisSpacing: 35),
        itemBuilder: (context, gridViewIndex) {
          return IngredientCircleAvatar(
            color: ColorConstants.instance.russianViolet.withOpacity(0.1),
            model: context.read<HomeCubit>().myFrizeItems[gridViewIndex],
            iconTopWidget: Text(
              context.read<HomeCubit>().myFrizeItems[gridViewIndex].quantity.toString(),
              style: TextStyle(color: ColorConstants.instance.white),
            ),
          );
        });
  }
}
