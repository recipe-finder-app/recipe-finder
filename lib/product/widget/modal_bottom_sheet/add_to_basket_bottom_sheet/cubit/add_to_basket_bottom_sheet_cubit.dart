import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/product/widget/modal_bottom_sheet/add_to_basket_bottom_sheet/cubit/add_to_basket_bottom_sheet_state.dart';

import '../../../../../core/base/model/base_view_model.dart';
import '../../../../../core/constant/enum/image_path_enum.dart';
import '../../../../model/ingradient_model.dart';

class AddToBasketCubit extends Cubit<IAddToBasketState>
    implements IBaseViewModel {
  bool? missingItemIsDragging;
  bool? myFrizeItemIsDragging;
  late List<IngredientModel> myFrizeItems = [
    IngredientModel(title: 'Egg', imagePath: ImagePath.egg.path, quantity: 1),
    IngredientModel(
        title: 'Milk', imagePath: ImagePath.milk.path, quantity: 0.25),
    IngredientModel(
        title: 'salad', imagePath: ImagePath.salad.path, quantity: 1),
    /* IngredientModel(
        title: 'chicken', imagePath: ImagePath.chicken.path, quantity: 1),
    IngredientModel(
        title: 'Potato', imagePath: ImagePath.potato.path, quantity: 0.25),*/
  ];
  List<IngredientModel> missingItemList = [];

  AddToBasketCubit() : super(AddToBasketInit());
  @override
  void init() {}

  void addItemToMissingList(IngredientModel model) {
    List<IngredientModel> value = missingItemList
        .where((element) => element.hashCode == model.hashCode)
        .toList();
    if (value.isEmpty) {
      missingItemList.add(model);
      emit(MissingItemListLoad(missingItemList.toSet().toList()!));
    }
  }

  void removeMissingItem(IngredientModel model) {
    List<IngredientModel> value = missingItemList
        .where((element) => element.hashCode == model.hashCode)
        .toList();
    if (value.isNotEmpty) {
      missingItemList.remove(model);

      emit(MissingItemListLoad(missingItemList.toSet().toList()!));
    }
  }

  void addItemToMyFrizeList(IngredientModel model) {
    List<IngredientModel> value = myFrizeItems
        .where((element) => element.hashCode == model.hashCode)
        .toList();
    if (value.isEmpty) {
      bool isContainTitle = false;
      IngredientModel? containModel;
      for (var item in myFrizeItems) {
        if (item.title.toLowerCase() == model.title.toLowerCase()) {
          isContainTitle = true;
          containModel = item;
          break;
        }
      }
      if (isContainTitle == true) {
        IngredientModel newElement = IngredientModel(
            title: model.title,
            imagePath: model.imagePath,
            color: model.color,
            quantity: model.quantity);
        //quantity: ((model.quantity ?? 0) + (containModel!.quantity ?? 0)));
        int index = myFrizeItems.indexOf(containModel!);
        myFrizeItems[index] = newElement;
        emit(MyFrizeListLoad(myFrizeItems.toSet().toList()));
      } else {
        myFrizeItems.add(model);
        emit(MyFrizeListLoad(myFrizeItems.toSet().toList()));
      }
    }
  }

  void removeMyFrizeItem(IngredientModel model) {
    List<IngredientModel> value = myFrizeItems
        .where((element) => element.hashCode == model.hashCode)
        .toList();
    if (value.isNotEmpty) {
      myFrizeItems.remove(model);

      emit(MyFrizeListLoad(myFrizeItems.toSet().toList()!));
    }
  }

  void missingItemLoad(List<IngredientModel> missingItems) {
    missingItemList = missingItems;
    emit(MissingItemListLoad(missingItemList.toSet().toList()));
  }

  void calculateMissingItemList(List<IngredientModel> recipeIngredientList,
      List<IngredientModel> myFrizeList) {
    missingItemList.clear();
    for (var myFrizeIngredient in myFrizeList) {
      for (var recipeIngredient in recipeIngredientList) {
        if ((myFrizeIngredient.title.toLowerCase() ==
                    recipeIngredient.title.toLowerCase() ||
                !myFrizeList.contains(recipeIngredient)) &&
            ((myFrizeIngredient.quantity ?? 0) <
                (recipeIngredient.quantity ?? 0)) &&
            !(missingItemList.contains(recipeIngredient))) {
          missingItemList.add(recipeIngredient);
        }
      }
    }
    missingItemLoad(missingItemList);
  }

  void myFrizeListLoad() {
    emit(MyFrizeListLoad(myFrizeItems.toSet().toList()!));
  }

  void missingItemDragging(bool isDragging) {
    missingItemIsDragging = isDragging;
    emit(MissingItemDragging(missingItemIsDragging!));
  }

  void myFrizeItemDragging(bool isDragging) {
    myFrizeItemIsDragging = isDragging;
    emit(MyFrizeItemDragging(myFrizeItemIsDragging!));
  }

  @override
  BuildContext? context;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void dispose() {}
}
