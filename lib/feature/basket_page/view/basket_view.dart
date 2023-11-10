import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/feature/basket_page/cubit/basket_state.dart';
import 'package:recipe_finder/feature/basket_page/service/basket_service.dart';
import 'package:recipe_finder/feature/discover_page/cubit/discover_cubit.dart';
import 'package:recipe_finder/feature/discover_page/cubit/discover_state.dart';
import 'package:recipe_finder/product/utils/constant/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/widget/alert_dialog/question_alert_dialog.dart';
import 'package:recipe_finder/product/widget/card/discover_card.dart';
import 'package:recipe_finder/product/widget/circle_avatar/ingredient_circle_avatar.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/init/language/language_manager.dart';
import '../../../core/widget/image_format/image_svg.dart';
import '../../../core/widget/text/locale_text.dart';
import '../../../product/model/recipe/recipe.dart';
import '../../../product/widget/card/basket_card.dart';
import '../../home_page/cubit/home_cubit.dart';
import '../cubit/basket_cubit.dart';

class BasketView extends StatefulWidget {
  const BasketView({Key? key}) : super(key: key);

  @override
  State<BasketView> createState() => _BasketViewState();
}

class _BasketViewState extends State<BasketView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  void _startAnimation() {
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<BasketCubit>(
        init: (cubitRead) async {
          _animationController = AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 500),
          );
          _animation =
              Tween<double>(begin: 0, end: 1).animate(_animationController);
          _startAnimation();
          await cubitRead.init();
        },
        dispose: (cubitRead) {
          _animationController.dispose();
        },
        visibleProgress: false,
        onPageBuilder: (BuildContext context, cubitRead, cubitWatch) =>
            Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: context.pagePadding,
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
                        BlocBuilder<BasketCubit, BasketState>(
                          builder: (context, state) {
                            if (state.selectedRecipe == Recipe() || state.selectedRecipe == null) {
                              return FadeTransition(
                                  opacity: _animation,
                                  child: const LocaleText(
                                      text:
                                          'Satın alım listesini görmek için yukarıdan kart seçin'));
                            } else {
                              return buildToBuyList(cubitRead);
                            }
                          },
                        ),
                        context.lowSizedBox,
                        LocaleText(
                          text: LocaleKeys.yourFrize,
                          style: TextStyle(
                            fontSize: 24,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.instance.russianViolet,
                          ),
                        ),
                        context.lowSizedBox,
                        buildGridViewMyFrize(context),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  Widget buildToBuyList(BasketCubit cubitRead) {
    return BlocBuilder<BasketCubit, BasketState>(
      builder: (context, state) {
        if(state.selectedRecipe?.ingredients==null || (state.selectedRecipe?.ingredients!=null && state.selectedRecipe!.ingredients!.isEmpty)){
          return const SizedBox.shrink();
        }
        else{
return FadeTransition(
          opacity: _animation,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: state.selectedRecipe?.ingredients?.length ?? 0,
            itemBuilder: (context, listViewIndex) {
                String recipeName = (context.locale == LanguageManager.instance.trLocale ? state.selectedRecipe!
                              .ingredients![listViewIndex].nameTR ?? '' : state.selectedRecipe!
                              .ingredients![listViewIndex].nameEN ?? '');
              return Padding(
                padding: EdgeInsets.only(
                    top: context.lowValue, bottom: context.lowValue),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IngredientCircleAvatar(
                          showText: false,
                          model: state.selectedRecipe!.ingredients![listViewIndex],
                        ),
                        context.normalSizedBoxWidth,
                        Padding(
                          padding: context.paddingHighBottom,
                          child: Text(recipeName),
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
                              backgroundColor:
                                  ColorConstants.instance.oriolesOrange,
                              child: ImageSvg(
                                path: ImagePathConstant.basketShop.path,
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
        
      },
    );
  }

  SizedBox myBasketListView(BuildContext context, BasketCubit cubitRead) {
    return SizedBox(
      height: context.normalhighValue,
      child: BlocBuilder<BasketCubit, BasketState>(
        builder: (context, state) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: cubitRead.basketRecipeItems.length,
            itemBuilder: (context, int cardIndex) {
              return Padding(
                padding: EdgeInsets.only(right: context.normalValue),
                child: BasketRecipeCard(
                  borderRadius: state.selectedColorIndex == cardIndex
                      ? null
                      : context.radiusAllCircularMedium,
                  height: state.selectedColorIndex == cardIndex ? 150 : 140,
                  width: state.selectedColorIndex == cardIndex ? 150 : 140,
                  model: cubitRead.basketRecipeItems[cardIndex],
                  cardOnPressed: () {
                    cubitRead.changeSelectedCardModel(
                        cubitRead.basketRecipeItems[cardIndex]);
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
                              cubitRead.deletedItemFromBasketRecipeList(
                                  cubitRead.basketRecipeItems[cardIndex]);
                              cubitRead.changeSelectedCardModel(null);
                              cubitRead.changeSelectedColorIndex(null);
                            },
                          );
                        });
                  }),
                  border: state.selectedColorIndex == cardIndex
                      ? Border.all(
                          color: cubitRead.selectedCardItemColor(cardIndex),
                          width: 6)
                      : null,
                  gradient: state.selectedColorIndex == cardIndex
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
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildGridViewMyFrize(BuildContext context) {
    return BlocBuilder<BasketCubit, BasketState>(
      builder: (context, state) {
        return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.myFrizeList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.70,
                crossAxisSpacing: 25,
                mainAxisSpacing: 15),
            itemBuilder: (context, gridViewIndex) {
              return IngredientCircleAvatar(
                color: ColorConstants.instance.russianViolet.withOpacity(0.1),
                model: state.myFrizeList[gridViewIndex],
                showText: false,
                iconTopWidget: Text(
                  context
                      .read<HomeCubit>()
                      .myFrizeItems[gridViewIndex]
                      .quantity
                      .toString(),
                  style: TextStyle(color: ColorConstants.instance.white),
                ),
              );
            });
      },
    );
  }
}
