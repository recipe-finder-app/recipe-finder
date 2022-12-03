import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/product/component/card/saved_recipe_card.dart';
import 'package:recipe_finder/product/component/modal_bottom_sheet/circular_modal_bottom_sheet.dart';
import 'package:recipe_finder/product/widget/button/recipe_circular_button.dart';
import 'package:recipe_finder/product/widget/button/recipe_fab_button.dart';
import 'package:recipe_finder/product/widget/circle_avatar/ingredient_circle_avatar.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../product/component/text/bold_text.dart';
import '../../../product/component/text/locale_bold_text.dart';
import '../../../product/model/ingradient_model.dart';
import '../../../product/widget/circle_avatar/draggable_ingredient_circle_avatar.dart';
import '../cubit/likes_cubit.dart';
import '../cubit/likes_state.dart';

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
                                cubitRead.missingItemLoad(cardIndex);
                                addToBasketBottomSheet(
                                    context, cubitRead, cardIndex);
                              },
                              recipeOnPressed: () {
                                recipeBottomSheet(
                                    context, cubitRead, cardIndex);
                              },
                              likeIconOnPressed: () {
                                cubitRead.deleteItemFromLikedRecipeList(
                                    cubitRead.likeRecipeItems[cardIndex]);
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

  Future<void> addToBasketBottomSheet(
      BuildContext context, LikesCubit cubitRead, int cardIndex) {
    return CircularBottomSheet.instance.show(
      context,
      bottomSheetHeight: CircularBottomSheetHeight.short,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Flexible(
              flex: 1, child: LocaleBoldText(text: LocaleKeys.missingItem)),
          if (cubitRead.likeRecipeItems[cardIndex].missingItems == null)
            const Center()
          else
            BlocSelector<LikesCubit, ILikesState, List<IngredientModel>>(
              selector: (state) {
                if (state is MissingItemListLoad) {
                  return state.missingItemList;
                } else {
                  return cubitRead.likeRecipeItems[cardIndex].missingItems ??
                      [];
                }
              },
              builder: (BuildContext context, state) {
                return Flexible(
                  flex: 4,
                  child: BlocBuilder<LikesCubit, ILikesState>(
                      builder: (BuildContext context, dragState) {
                    if (cubitRead.missingItemListTargetState == true) {
                      return DragTarget<int>(
                          onWillAccept: (data) {
                            return true;
                          },
                          onAccept: (data) {},
                          builder: (BuildContext context,
                              List<Object?> candidateData,
                              List<dynamic> rejectedData) {
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.length,
                                itemBuilder: (BuildContext context,
                                    int missingItemIndex) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        right: context.lowValue),
                                    child: DraggableIngredientCircleAvatar<int>(
                                      data: missingItemIndex,
                                      onDragStarted: () {
                                        cubitRead
                                            .changeMissingItemListTargetState(
                                                false);
                                        cubitRead
                                            .changeMyFrizeListTargetState(true);
                                      },
                                      onDragEnd:
                                          (DraggableDetails draggableDetails) {
                                        if (draggableDetails.wasAccepted ==
                                            true) {
                                          cubitRead.addItemToMyFrizeList(
                                              state[missingItemIndex]);
                                          cubitRead.removeMissingItem(
                                              cardIndex, missingItemIndex);
                                        }
                                      },
                                      iconBottomWidget: BoldText(
                                        text: state[missingItemIndex]
                                            .quantity
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      color: ColorConstants
                                          .instance.oriolesOrange
                                          .withOpacity(0.4),
                                      model: state[missingItemIndex],
                                    ),
                                  );
                                });
                          });
                    } else {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.length,
                          itemBuilder:
                              (BuildContext context, int missingItemIndex) {
                            return Padding(
                              padding: EdgeInsets.only(right: context.lowValue),
                              child: DraggableIngredientCircleAvatar<int>(
                                data: missingItemIndex,
                                onDragUpdate: (d) {},
                                onDragStarted: () {
                                  cubitRead
                                      .changeMissingItemListTargetState(false);
                                  cubitRead.changeMyFrizeListTargetState(true);
                                },
                                onDragEnd: (DraggableDetails draggableDetails) {
                                  if (draggableDetails.wasAccepted == true) {
                                    cubitRead.addItemToMyFrizeList(
                                        state[missingItemIndex]);
                                    cubitRead.removeMissingItem(
                                        cardIndex, missingItemIndex);
                                  }
                                },
                                iconBottomWidget: BoldText(
                                  text: state[missingItemIndex]
                                      .quantity
                                      .toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                color: ColorConstants.instance.oriolesOrange
                                    .withOpacity(0.4),
                                model: state[missingItemIndex],
                              ),
                            );
                          });
                    }
                  }),
                );
              },
            ),
          const Flexible(
              flex: 1, child: LocaleBoldText(text: LocaleKeys.yourFrize)),
          BlocSelector<LikesCubit, ILikesState, List<IngredientModel>>(
              selector: (state) {
            if (state is MyFrizeListLoad) {
              return state.myFrizeList;
            } else {
              return cubitRead.myFrizeItems ?? [];
            }
          }, builder: (BuildContext context, state) {
            return Flexible(
              flex: 4,
              child: cubitRead.myFrizeItems == null
                  ? const Center()
                  : BlocBuilder<LikesCubit, ILikesState>(
                      builder: (BuildContext context, dragState) {
                      if (cubitRead.myFrizeListTargetState == true) {
                        return DragTarget<int>(
                          onWillAccept: (data) {
                            return true;
                          },
                          onAccept: (data) {},
                          builder: (BuildContext context,
                              List<Object?> candidateData,
                              List<dynamic> rejectedData) {
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.length,
                                itemBuilder: (BuildContext context,
                                    int myFrizeItemIndex) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        right: context.lowValue),
                                    child: DraggableIngredientCircleAvatar<int>(
                                      data: myFrizeItemIndex,
                                      onDragStarted: () {
                                        cubitRead.changeMyFrizeListTargetState(
                                            false);
                                        cubitRead
                                            .changeMissingItemListTargetState(
                                                true);
                                      },
                                      onDragEnd:
                                          (DraggableDetails draggableDetails) {
                                        if (draggableDetails.wasAccepted ==
                                            true) {
                                          cubitRead.addItemToMissingList(
                                              cardIndex,
                                              state[myFrizeItemIndex]);
                                          cubitRead.removeMyFrizeItem(
                                              myFrizeItemIndex);
                                        }
                                      },
                                      iconBottomWidget: BoldText(
                                        text: state[myFrizeItemIndex]
                                            .quantity
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      color: ColorConstants
                                          .instance.brightGraySolid2,
                                      model: state[myFrizeItemIndex],
                                    ),
                                  );
                                });
                          },
                        );
                      } else {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.length,
                            itemBuilder:
                                (BuildContext context, int myFrizeItemIndex) {
                              return Padding(
                                padding:
                                    EdgeInsets.only(right: context.lowValue),
                                child: DraggableIngredientCircleAvatar<int>(
                                  data: myFrizeItemIndex,
                                  onDragStarted: () {
                                    cubitRead
                                        .changeMyFrizeListTargetState(false);
                                    cubitRead
                                        .changeMissingItemListTargetState(true);
                                  },
                                  onDragEnd:
                                      (DraggableDetails draggableDetails) {
                                    if (draggableDetails.wasAccepted == true) {
                                      cubitRead.addItemToMissingList(
                                          cardIndex, state[myFrizeItemIndex]);
                                      cubitRead
                                          .removeMyFrizeItem(myFrizeItemIndex);
                                    }
                                  },
                                  iconBottomWidget: BoldText(
                                    text: state[myFrizeItemIndex]
                                        .quantity
                                        .toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  color:
                                      ColorConstants.instance.brightGraySolid2,
                                  model: state[myFrizeItemIndex],
                                ),
                              );
                            });
                      }
                    }),
            );
          }),
          RecipeCircularButton(
              color: ColorConstants.instance.oriolesOrange,
              text: LocaleKeys.confirm),
        ],
      ),
    );
  }

  Future<void> recipeBottomSheet(
      BuildContext context, LikesCubit cubitRead, int cardIndex) {
    return CircularBottomSheet.instance.show(
      context,
      resizeToAvoidBottomInset: true,
      scrollable: true,
      bottomSheetHeight: CircularBottomSheetHeight.standard,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LocaleBoldText(text: LocaleKeys.ingredients),
          context.lowSizedBox,
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cubitRead
                  .likeRecipeItems[cardIndex].recipeModel.ingredients.length,
              itemBuilder: (BuildContext context, int recipeIngredientsIndex) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(cubitRead.likeRecipeItems[cardIndex].recipeModel
                        .ingredients[recipeIngredientsIndex].quantity
                        .toString()),
                    Text(cubitRead.likeRecipeItems[cardIndex].recipeModel
                        .ingredients[recipeIngredientsIndex].title),
                  ],
                );
              }),
          const LocaleBoldText(text: LocaleKeys.yourFrize),
          context.lowSizedBox,
          cubitRead.myFrizeItems == null
              ? const Center()
              : SizedBox(
                  height: context.screenHeight / 8,
                  width: context.screenWidth,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: cubitRead.myFrizeItems.length,
                      itemBuilder:
                          (BuildContext context, int missingItemIndex) {
                        return Padding(
                          padding: EdgeInsets.only(right: context.lowValue),
                          child: IngredientCircleAvatar(
                            color: ColorConstants.instance.russianViolet
                                .withOpacity(0.1),
                            model: cubitRead.myFrizeItems[missingItemIndex],
                            iconBottomWidget: Text(
                              cubitRead.myFrizeItems[missingItemIndex].quantity
                                  .toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }),
                ),
          const LocaleBoldText(text: LocaleKeys.description),
          context.lowSizedBox,
          Text(
            cubitRead.likeRecipeItems[cardIndex].recipeModel.description,
            style: const TextStyle(overflow: TextOverflow.ellipsis),
            maxLines: 3,
          ),
          context.lowSizedBox,
          const LocaleBoldText(text: LocaleKeys.directions),
          context.lowSizedBox,
          Text(
            cubitRead.likeRecipeItems[cardIndex].recipeModel.directions,
            style: const TextStyle(overflow: TextOverflow.clip),
          ),
          context.lowSizedBox,
          RecipeFabButton(
              color: ColorConstants.instance.russianViolet,
              text: LocaleKeys.addToBasket),
        ],
      ),
    );
  }
}
