import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/product/model/recipe_model.dart';
import 'package:recipe_finder/product/widget/circle_avatar/ingredient_circle_avatar.dart';
import 'package:recipe_finder/product/widget_core/text/locale_text.dart';

import '../../../../../core/constant/design/color_constant.dart';
import '../../../../../core/init/language/locale_keys.g.dart';
import '../../../../../feature/basket_page/cubit/basket_cubit.dart';
import '../../../../model/ingredient/ingredient_model.dart';
import '../../../../widget_core/modal_bottom_sheet/circular_modal_bottom_sheet.dart';
import '../../../../widget_core/text/bold_text.dart';
import '../../../../widget_core/text/locale_bold_text.dart';
import '../../../button/recipe_circular_button.dart';
import '../../../circle_avatar/draggable_ingredient_circle_avatar.dart';
import '../cubit/add_to_basket_bottom_sheet_cubit.dart';
import '../cubit/add_to_basket_bottom_sheet_state.dart';

class AddToBasketBottomSheet {
  static AddToBasketBottomSheet instance = AddToBasketBottomSheet._init();
  AddToBasketBottomSheet._init();

  Future<void> show(BuildContext context, RecipeModel recipeModel) {
    context.read<AddToBasketCubit>().calculateMissingItemList(recipeModel, context.read<AddToBasketCubit>().myFrizeItemList);
    context.read<AddToBasketCubit>().setFirstItemLists(context.read<AddToBasketCubit>().myFrizeItemList, context.read<AddToBasketCubit>().missingItemList);
    return CircularBottomSheet.instance.show(
      context,
      bottomSheetHeight: CircularBottomSheetHeight.short,
      onDismiss: () {
        context.read<AddToBasketCubit>().undoAll();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    context.read<AddToBasketCubit>().undoAll();
                  },
                  child: LocaleBoldText(
                    text: LocaleKeys.undoAll,
                    fontSize: 12,
                  )),
              TextButton(
                  onPressed: () {
                    context.read<AddToBasketCubit>().undo();
                  },
                  child: LocaleBoldText(
                    text: LocaleKeys.undo,
                    fontSize: 12,
                  )),
            ],
          ),
          Flexible(flex: 1, child: LocaleBoldText(text: LocaleKeys.missingItem)),
          if (context.read<AddToBasketCubit>().missingItemList.isEmpty)
            const Center()
          else
            BlocSelector<AddToBasketCubit, IAddToBasketState, bool>(
              selector: (draggingState) {
                if (draggingState is MyFrizeItemDragging) {
                  return draggingState.isDragging;
                } else {
                  return false;
                }
              },
              builder: (context, draggingState) {
                return BlocSelector<AddToBasketCubit, IAddToBasketState, List<IngredientModel>>(
                  selector: (state) {
                    if (state is MissingItemListLoad) {
                      return state.missingItemList;
                    } else {
                      return context.read<AddToBasketCubit>().missingItemList;
                    }
                  },
                  builder: (BuildContext context, state) {
                    return Flexible(
                      flex: 4,
                      child: DragTarget<IngredientModel>(onAccept: (data) {
                        context.read<AddToBasketCubit>().addItemToMissingList(data);
                        context.read<AddToBasketCubit>().removeMyFrizeItem(data);
                      }, builder: (BuildContext context, List<Object?> candidateData, List<dynamic> rejectedData) {
                        if (draggingState == true) {
                          return DottedBorder(borderType: BorderType.RRect, dashPattern: const [8, 4], radius: const Radius.circular(12), padding: const EdgeInsets.all(6), child: _missingItemsListView(state));
                        } else {
                          return _missingItemsListView(state);
                        }
                      }),
                    );
                  },
                );
              },
            ),
          Visibility(
            visible: context.read<AddToBasketCubit>().missingItemList.isEmpty ? false : true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_downward),
                SizedBox(
                  width: context.screenWidth / 1.5,
                  child: const LocaleText(
                    text: LocaleKeys.grabAndDrag,
                    maxLines: 3,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const Flexible(flex: 1, child: LocaleBoldText(text: LocaleKeys.yourFrize)),
          BlocSelector<AddToBasketCubit, IAddToBasketState, bool>(selector: (draggingState) {
            if (draggingState is MissingItemDragging) {
              return draggingState.isDragging;
            } else {
              return false;
            }
          }, builder: (context, draggingState) {
            return BlocSelector<AddToBasketCubit, IAddToBasketState, List<IngredientModel>>(selector: (state) {
              if (state is MyFrizeListLoad) {
                return state.myFrizeItemList;
              } else {
                return context.read<AddToBasketCubit>().myFrizeItemList ?? [];
              }
            }, builder: (BuildContext context, state) {
              return Flexible(
                flex: 4,
                child: context.read<AddToBasketCubit>().myFrizeItemList == null
                    ? const Center()
                    : DragTarget<IngredientModel>(onAccept: (data) {
                        context.read<AddToBasketCubit>().addItemToMyFrizeList(data);
                        context.read<AddToBasketCubit>().removeMissingItem(data);
                      }, builder: (BuildContext context, List<Object?> candidateData, List<dynamic> rejectedData) {
                        if (draggingState == true) {
                          return DottedBorder(borderType: BorderType.RRect, dashPattern: const [8, 4], radius: const Radius.circular(12), padding: const EdgeInsets.all(6), child: _myFrizeItemListView(state));
                        } else {
                          return _myFrizeItemListView(state);
                        }
                      }),
              );
            });
          }),
          RecipeCircularButton(
            color: ColorConstants.instance.oriolesOrange,
            text: LocaleKeys.confirm,
            onPressed: () {
              context.read<BasketCubit>().addItemFromBasketRecipeList(recipeModel);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  ListView _myFrizeItemListView(List<IngredientModel> state) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.length,
        itemBuilder: (BuildContext context, int myFrizeItemIndex) {
          return Padding(
            padding: EdgeInsets.only(right: context.lowValue),
            child: IngredientCircleAvatar(
              iconTopWidget: BoldText(
                text: state[myFrizeItemIndex].quantity.toString(),
                textColor: Colors.white,
              ),
              color: ColorConstants.instance.brightGraySolid2,
              model: state[myFrizeItemIndex],
            ),
            /*DraggableIngredientCircleAvatar<IngredientModel>(
              data: state[myFrizeItemIndex],
              onDragStarted: () {
                context.read<AddToBasketCubit>().myFrizeItemDragging(true);
              },
              onDragEnd: (value) {
                context.read<AddToBasketCubit>().myFrizeItemDragging(false);
              },
              iconTopWidget: BoldText(
                text: state[myFrizeItemIndex].quantity.toString(),
                textColor: Colors.white,
              ),
              color: ColorConstants.instance.brightGraySolid2,
              model: state[myFrizeItemIndex],
            ),*/
          );
        });
  }

  ListView _missingItemsListView(List<IngredientModel> state) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.length,
        itemBuilder: (BuildContext context, int missingItemIndex) {
          return Padding(
            padding: EdgeInsets.only(right: context.lowValue),
            child: DraggableIngredientCircleAvatar<IngredientModel>(
              data: state[missingItemIndex],
              onDragStarted: () {
                context.read<AddToBasketCubit>().missingItemDragging(true);
              },
              onDragEnd: (value) {
                context.read<AddToBasketCubit>().missingItemDragging(false);
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
