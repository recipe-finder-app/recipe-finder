import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/feature/basket_page/view/basket_card.dart';
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
                                model: cubitRead.basketRecipeItems[cardIndex],
                                cardOnPressed: () {
                                  cubitRead.changeSelectedCardModel(
                                      cubitRead.basketRecipeItems[cardIndex]);
                                },
                                removeIconOnPressed: (() {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return QuestionAlertDialog(
                                          explanation: LocaleKeys.removeCard,
                                          onPressedYes: () {
                                            cubitRead
                                                .deleteItemFromBasketRecipeList(
                                                    cubitRead.basketRecipeItems[
                                                        cardIndex]);
                                          },
                                        );
                                      });
                                }),
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
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: cubitRead
                                    .selectCardModel?.ingredients.length,
                                itemBuilder: (context, listViewIndex) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: context.highValue),
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            IngredientCircleAvatar(
                                              color: ColorConstants
                                                  .instance.russianViolet
                                                  .withOpacity(0.1),
                                              model: cubitRead.selectCardModel!
                                                  .ingredients[listViewIndex],
                                            ),
                                            context.normalSizedBoxWidth,
                                            Text(cubitRead
                                                .selectCardModel!
                                                .ingredients[listViewIndex]
                                                .title),
                                          ],
                                        ),
                                        context.verySizedBoxWidth,
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.grey,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.done,
                                              color:
                                                  ColorConstants.instance.white,
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                        context.lowSizedBoxWidth,
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.red,
                                          child: IconButton(
                                            icon: const Icon(
                                                Icons.shopping_cart,
                                                color: Colors.white),
                                            onPressed: () {},
                                          ),
                                        ),
                                      ],
                                    ),
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
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: context.read<HomeCubit>().myFrizeItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.75,
            crossAxisSpacing: 30,
            mainAxisSpacing: 25),
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
