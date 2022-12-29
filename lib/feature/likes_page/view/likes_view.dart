import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/product/widget/alert_dialog/question_alert_dialog.dart';
import 'package:recipe_finder/product/widget/button/go_to_top_fab_button.dart';
import 'package:recipe_finder/product/widget/button/recipe_circular_button.dart';
import 'package:recipe_finder/product/widget_core/modal_bottom_sheet/circular_modal_bottom_sheet.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/constant/navigation/navigation_constants.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../../../product/model/ingradient_model.dart';
import '../../../product/widget/card/saved_recipe_card.dart';
import '../../../product/widget/circle_avatar/draggable_ingredient_circle_avatar.dart';
import '../../../product/widget_core/text/bold_text.dart';
import '../../../product/widget_core/text/locale_bold_text.dart';
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
        backgroundColor: Colors.white,
        floatingActionButton: GoToTopFabButton(
          scrollController: cubitRead.scrollController,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            controller: cubitRead.scrollController,
            child: Padding(
              padding: EdgeInsets.only(
                  top: context.mediumValue,
                  left: context.normalValue,
                  right: context.normalValue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LocaleBoldText(
                    text: LocaleKeys.mySavedRecipes,
                    fontSize: 29,
                  ),
                  context.normalSizedBox,
                  GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cubitRead.likeRecipeItems.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 3 / 4,
                      ),
                      itemBuilder: (BuildContext context, int cardIndex) {
                        return LikesRecipeCard(
                          model:
                              cubitRead.likeRecipeItems[cardIndex].recipeModel,
                          addToBasketOnPressed: () {
                            cubitRead.missingItemLoad(cardIndex);
                            addToBasketBottomSheet(
                                context, cubitRead, cardIndex);
                          },
                          recipeOnPressed: () {
                            NavigationService.instance.navigateToPage(
                                path: NavigationConstants.RECIPE_DETAIL,
                                data: cubitRead
                                    .likeRecipeItems[cardIndex].recipeModel);
                            /* recipeBottomSheet(
                                context, cubitRead, cardIndex);*/
                          },
                          likeIconOnPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return QuestionAlertDialog(
                                    explanation:
                                        LocaleKeys.deleteSavedRecipeQuestion,
                                    onPressedYes: () {
                                      cubitRead.deleteItemFromLikedRecipeList(
                                          cubitRead.likeRecipeItems[cardIndex]);
                                    },
                                  );
                                });
                          },
                        );
                      }),
                ],
              ),
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
                  child: DragTarget<IngredientModel>(onAccept: (data) {
                    cubitRead.addItemToMissingList(cardIndex, data);
                    cubitRead.removeMyFrizeItem(data);
                  }, builder: (BuildContext context,
                      List<Object?> candidateData, List<dynamic> rejectedData) {
                    return BlocSelector<LikesCubit, ILikesState, bool>(
                        selector: (draggingState) {
                      if (draggingState is MyFrizeItemDragging) {
                        return draggingState.isDragging;
                      } else {
                        return false;
                      }
                    }, builder: (context, draggingState) {
                      if (draggingState == true) {
                        return DottedBorder(
                            borderType: BorderType.RRect,
                            dashPattern: const [8, 4],
                            radius: const Radius.circular(12),
                            padding: const EdgeInsets.all(6),
                            child: missingItemsListView(
                                state, cubitRead, cardIndex));
                      } else {
                        print('missing item without dot');
                        return missingItemsListView(
                            state, cubitRead, cardIndex);
                      }
                    });
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
                  : DragTarget<IngredientModel>(onAccept: (data) {
                      cubitRead.addItemToMyFrizeList(data);
                      cubitRead.removeMissingItem(cardIndex, data);
                    }, builder: (BuildContext context,
                      List<Object?> candidateData, List<dynamic> rejectedData) {
                      return BlocSelector<LikesCubit, ILikesState, bool>(
                          selector: (draggingState) {
                        if (draggingState is MissingItemDragging) {
                          return draggingState.isDragging;
                        } else {
                          return false;
                        }
                      }, builder: (context, draggingState) {
                        if (draggingState == true) {
                          print('my frize item with dot');
                          return DottedBorder(
                              borderType: BorderType.RRect,
                              dashPattern: const [8, 4],
                              radius: const Radius.circular(12),
                              padding: const EdgeInsets.all(6),
                              child: myFrizeItemListView(state, cubitRead));
                        } else {
                          print('my frize item without dot');
                          return myFrizeItemListView(state, cubitRead);
                        }
                      });
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

  ListView myFrizeItemListView(
      List<IngredientModel> state, LikesCubit cubitRead) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.length,
        itemBuilder: (BuildContext context, int myFrizeItemIndex) {
          return Padding(
            padding: EdgeInsets.only(right: context.lowValue),
            child: DraggableIngredientCircleAvatar<IngredientModel>(
              data: state[myFrizeItemIndex],
              onDragStarted: () {
                print('my frize drag started');
                cubitRead.myFrizeItemDragging(true);
              },
              onDragEnd: (value) {
                print('my frize drag ended');
                cubitRead.myFrizeItemDragging(false);
              },
              iconTopWidget: BoldText(
                text: state[myFrizeItemIndex].quantity.toString(),
                textColor: Colors.white,
              ),
              color: ColorConstants.instance.brightGraySolid2,
              model: state[myFrizeItemIndex],
            ),
          );
        });
  }

  ListView missingItemsListView(
      List<IngredientModel> state, LikesCubit cubitRead, int cardIndex) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.length,
        itemBuilder: (BuildContext context, int missingItemIndex) {
          return Padding(
            padding: EdgeInsets.only(right: context.lowValue),
            child: DraggableIngredientCircleAvatar<IngredientModel>(
              data: state[missingItemIndex],
              onDragStarted: () {
                print('missing item drag started');
                cubitRead.missingItemDragging(true);
              },
              onDragEnd: (value) {
                print('missing item drag ended');
                cubitRead.missingItemDragging(false);
              },
              iconTopWidget: BoldText(
                text: state[missingItemIndex].quantity.toString(),
                textColor: Colors.white,
              ),
              color: ColorConstants.instance.oriolesOrange.withOpacity(0.4),
              model: state[missingItemIndex],
            ),
          );
        });
  }
}
