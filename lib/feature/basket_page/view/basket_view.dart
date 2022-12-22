import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/feature/basket_page/view/basket_card.dart';
import 'package:recipe_finder/product/component/image_format/image_svg.dart';
import 'package:recipe_finder/product/component/text/locale_text.dart';
import 'package:recipe_finder/product/widget/alert_dialog/question_alert_dialog.dart';
import 'package:recipe_finder/product/widget/circle_avatar/ingredient_circle_avatar.dart';
import '../../../core/base/view/base_view.dart';
import '../../home_page/cubit/home_cubit.dart';
import '../cubit/basket_cubit.dart';

class BasketView extends StatelessWidget {
  const BasketView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<BasketCubit>(
        init: (cubitRead) {
          cubitRead.init();
        },
        visibleProgress: false,
        onPageBuilder: (BuildContext context, cubitRead, cubitWatch) =>
            Scaffold(
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
                        SizedBox(
                          height: context.normalhighValue,
                          width: context.screenWidth,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: cubitRead.basketRecipeItems.length,
                            itemBuilder: (context, int cardIndex) {
                              return BasketRecipeCard(
                                height:
                                    cubitRead.selectedColorIndex == cardIndex
                                        ? 130
                                        : 120,
                                width: cubitRead.selectedColorIndex == cardIndex
                                    ? 130
                                    : 120,
                                model: cubitRead.basketRecipeItems[cardIndex],
                                cardOnPressed: () {
                                  cubitRead.changeSelectedCardModel(
                                      cubitRead.basketRecipeItems[cardIndex]);
                                  cubitRead.changeSelectedColorIndex(cardIndex);
                                },
                                removeIconOnPressed: (() {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return QuestionAlertDialog(
                                          explanation: LocaleKeys.removeCard,
                                          onPressedYes: () {
                                            cubitRead
                                                .deletedItemFromBasketRecipeList(
                                                    cubitRead.basketRecipeItems[
                                                        cardIndex]);

                                           
                                                   cubitRead.changeSelectedCardModel(null);
                                          },
                                       
                                        );
                                      });
                                }),
                                border: cubitRead.selectedColorIndex ==
                                        cardIndex
                                    ? Border.all(
                                        color: cubitRead
                                            .selectedCardItemColor(cardIndex),
                                        width: 6)
                                    : null,
                                gradient: cubitRead.selectedColorIndex ==
                                        cardIndex
                                    ? LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: const [0, 0, 0.2, 1],
                                        colors: [
                                          cubitRead
                                              .selectedCardItemColor(cardIndex),
                                          Colors.transparent,
                                          Colors.transparent,
                                          cubitRead
                                              .selectedCardItemColor(cardIndex),
                                        ],
                                      )
                                    : LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: const [0, 0, 0.2, 1],
                                        colors: [
                                          cubitRead
                                              .selectedCardItemColor(cardIndex),
                                          Colors.transparent,
                                          Colors.transparent,
                                          cubitRead
                                              .selectedCardItemColor(cardIndex),
                                        ],
                                      ),
                              );
                            },
                          ),
                        ),
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
                        cubitRead.selectCardModel == null
                            ? const LocaleText(
                                text:
                                    'Satın alım listesini görmek için yukarıdan kart seçin')
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: cubitRead
                                    .selectCardModel?.ingredients.length,
                                itemBuilder: (context, listViewIndex) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          IngredientCircleAvatar(
                                            color: ColorConstants
                                                .instance.russianViolet
                                                .withOpacity(0.1),
                                            model: cubitRead.selectCardModel!
                                                .ingredients[listViewIndex],
                                            iconBottomWidget: Text(
                                              cubitRead
                                                  .selectCardModel!
                                                  .ingredients[listViewIndex]
                                                  .quantity
                                                  .toString(),
                                              style: TextStyle(
                                                  color: ColorConstants
                                                      .instance.white),
                                            ),
                                          ),
                                          context.normalSizedBoxWidth,
                                          Padding(
                                            padding: context.paddingHighBottom,
                                            child: Text(cubitRead
                                                .selectCardModel!
                                                .ingredients[listViewIndex]
                                                .title),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: context.paddingHighBottom,
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 20,
                                              backgroundColor: ColorConstants
                                                  .instance.chenille,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.done,
                                                  color: ColorConstants
                                                      .instance.white,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                            context.lowSizedBoxWidth,
                                            CircleAvatar(
                                                radius: 20,
                                                backgroundColor: ColorConstants
                                                    .instance.oriolesOrange,
                                                child: ImageSvg(
                                                  path:
                                                      ImagePath.basketShop.path,
                                                )),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
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

  GridView buildGridViewMyPantry(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: context.read<HomeCubit>().myFrizeItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.70,
            crossAxisSpacing: 30,
            mainAxisSpacing: 35),
        itemBuilder: (context, gridViewIndex) {
          return IngredientCircleAvatar(
            color: ColorConstants.instance.russianViolet.withOpacity(0.1),
            model: context.read<HomeCubit>().myFrizeItems[gridViewIndex],
            iconBottomWidget: Text(
              context
                  .read<HomeCubit>()
                  .myFrizeItems[gridViewIndex]
                  .quantity
                  .toString(),
              style: TextStyle(color: ColorConstants.instance.white),
            ),
          );
        });
  }
}
