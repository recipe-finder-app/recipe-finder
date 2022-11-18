import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/product/component/alert_dialog/alert_dialog_error.dart';
import 'package:recipe_finder/product/component/card/saved_recipe_card.dart';
import 'package:recipe_finder/product/component/modal_bottom_sheet/circular_modal_bottom_sheet.dart';
import 'package:recipe_finder/product/component/text/bold_text.dart';
import 'package:recipe_finder/product/widget/button/recipe_circular_button.dart';
import 'package:recipe_finder/product/widget/circle_avatar/ingredient_circle_avatar.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../product/component/text/locale_bold_text.dart';
import '../../../product/widget/circle_avatar/draggable_ingredient_circle_avatar.dart';
import '../cubit/likes_cubit.dart';

class LikesView extends StatelessWidget {
  const LikesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LikesCubit>(
      init: (cubitRead) {
        cubitRead.init();
      },
      visibleProgress: false,
      onPageBuilder: (BuildContext context, cubitRead, cubitWatch) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: context.normalValue),
                  child: Padding(
                    padding: EdgeInsets.only(top: context.mediumValue),
                    child: const LocaleBoldText(
                      text: LocaleKeys.mySavedRecipes,
                      fontSize: 29,
                    ),
                  ),
                ),
                context.normalSizedBox,
                GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cubitRead.likeRecipeItems.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 4,
                    ),
                    itemBuilder: (BuildContext context, int cardIndex) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: cardIndex % 2 != 0 ? context.lowValue : 0,
                          right: cardIndex % 2 != 0 ? context.normalValue : 0,
                        ),
                        child: Padding(
                            padding: EdgeInsets.only(
                              left:
                                  cardIndex % 2 == 0 ? context.normalValue : 0,
                              right: cardIndex % 2 == 0 ? context.lowValue : 0,
                              bottom: context.normalValue,
                            ),
                            child: LikesRecipeCard(
                              model: cubitRead.likeRecipeItems[cardIndex],
                              addToBasketOnPressed: () {
                                CircularBottomSheet.instance.show(
                                  context,
                                  bottomSheetHeight:
                                      CircularBottomSheetHeight.short,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Flexible(
                                          flex: 1,
                                          child: LocaleBoldText(
                                              text: LocaleKeys.missingItem)),
                                      Flexible(
                                        flex: 4,
                                        child: cubitRead
                                                    .likeRecipeItems[cardIndex]
                                                    .missingItems ==
                                                null
                                            ? const Center()
                                            : ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: cubitRead
                                                    .likeRecipeItems[cardIndex]
                                                    .missingItems
                                                    ?.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int missingItemIndex) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        right:
                                                            context.lowValue),
                                                    child:
                                                        DraggableIngredientCircleAvatar(
                                                      data: 'true',
                                                      onDragEnd:
                                                          (DraggableDetails
                                                              draggableDetails) {
                                                        if (draggableDetails
                                                                .wasAccepted ==
                                                            true) {
                                                          cubitRead.addItemMyFrize(
                                                              cardIndex,
                                                              cubitRead
                                                                      .likeRecipeItems[
                                                                          cardIndex]
                                                                      .missingItems![
                                                                  missingItemIndex]);
                                                        }
                                                      },
                                                      widgetOnIcon: BoldText(
                                                        text: cubitRead
                                                            .likeRecipeItems[
                                                                cardIndex]
                                                            .missingItems![
                                                                missingItemIndex]
                                                            .quantity
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      color: ColorConstants
                                                          .instance
                                                          .oriolesOrange
                                                          .withOpacity(0.4),
                                                      model: cubitRead
                                                              .likeRecipeItems[
                                                                  cardIndex]
                                                              .missingItems![
                                                          missingItemIndex],
                                                    ),
                                                  );
                                                }),
                                      ),
                                      const Flexible(
                                          flex: 1,
                                          child: LocaleBoldText(
                                              text: LocaleKeys.yourFrize)),
                                      Flexible(
                                        flex: 4,
                                        child: cubitRead.myFrizeItems == null
                                            ? const Center()
                                            : DragTarget(
                                                onWillAccept: (data) {
                                                  return data == 'true';
                                                },
                                                onAccept: (data) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialogError(
                                                            text: 'başarılı');
                                                      });
                                                },
                                                builder: (BuildContext context,
                                                    List<Object?> candidateData,
                                                    List<dynamic>
                                                        rejectedData) {
                                                  return ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: cubitRead
                                                          .myFrizeItems.length,
                                                      itemBuilder: (BuildContext
                                                              context,
                                                          int missingItemIndex) {
                                                        return Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: context
                                                                      .lowValue),
                                                          child:
                                                              IngredientCircleAvatar(
                                                            color: ColorConstants
                                                                .instance
                                                                .russianViolet
                                                                .withOpacity(
                                                                    0.1),
                                                            model: cubitRead
                                                                    .myFrizeItems[
                                                                missingItemIndex],
                                                          ),
                                                        );
                                                      });
                                                },
                                              ),
                                      ),
                                      RecipeCircularButton(
                                          color: ColorConstants
                                              .instance.oriolesOrange,
                                          text: LocaleKeys.confirm),
                                    ],
                                  ),
                                );
                              },
                            )),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
