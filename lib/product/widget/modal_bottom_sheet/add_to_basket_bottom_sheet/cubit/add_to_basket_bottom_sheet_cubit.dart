import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/product/widget/modal_bottom_sheet/add_to_basket_bottom_sheet/cubit/add_to_basket_bottom_sheet_state.dart';

import '../../../../../core/constant/enum/image_path_enum.dart';
import '../../../../model/ingredient/ingredient_model.dart';
import '../../../../model/recipe/recipe_model.dart';

class AddToBasketCubit extends Cubit<IAddToBasketState> {
  bool? missingItemIsDragging;
  bool? myFrizeItemIsDragging;
  late List<IngredientModel> myFrizeItemList = [
    IngredientModel(title: 'Egg', imagePath: ImagePath.egg.path, quantity: 1),
    IngredientModel(title: 'Milk', imagePath: ImagePath.milk.path, quantity: 0.25),
    IngredientModel(title: 'salad', imagePath: ImagePath.salad.path, quantity: 1),
    /* IngredientModel(
        title: 'chicken', imagePath: ImagePath.chicken.path, quantity: 1),
    IngredientModel(
        title: 'Potato', imagePath: ImagePath.potato.path, quantity: 0.25),*/
  ];
  List<IngredientModel> missingItemList = [];

  List<List<IngredientModel>> previousMissingItemList = [];
  List<List<IngredientModel>> previousMyFrizeItemList = [];

  List<IngredientModel> firstMissingItemList = [];
  List<IngredientModel> firstMyFrizeItemList = [];

  AddToBasketCubit() : super(AddToBasketInit());

  void setFirstItemLists(List<IngredientModel> myFrizeList, List<IngredientModel> missingList) {
    firstMissingItemList.clear();
    firstMyFrizeItemList.clear();
    firstMissingItemList.addAll(missingList.toSet().toList()); //burayı addAll ile yapmak önemli.İki listeyi birbirine eşitleyince bu methodu birkere çalıştırsanda yine de son haline eşit oluyor.Referans tipi muhabbeti.Böyle olunca sıkıntı olmuyor.
    firstMyFrizeItemList.addAll(myFrizeList.toSet().toList());
  }

  void undoAll() {
    missingItemList.clear();
    myFrizeItemList.clear();
    missingItemList.addAll(firstMissingItemList.toSet().toList());
    myFrizeItemList.addAll(firstMyFrizeItemList.toSet().toList());
    missingItemLoad(missingItemList);
    myFrizeListLoad();
  }

  void undo() {
    if (previousMissingItemList.length > 0) {
      missingItemList.clear();
      missingItemList.addAll(previousMissingItemList.last.toSet().toList());
      previousMissingItemList.removeLast();
      missingItemLoad(missingItemList);
    }
    if (previousMyFrizeItemList.length > 0) {
      myFrizeItemList.clear();
      myFrizeItemList.addAll(previousMyFrizeItemList.last.toSet().toList());
      previousMyFrizeItemList.removeLast();
      myFrizeListLoad();
    }
  }

  void addItemToMissingList(IngredientModel model) {
    List<IngredientModel> value = missingItemList.where((element) => element.hashCode == model.hashCode).toList();
    if (value.isEmpty) {
      previousMissingItemList.add(missingItemList.toSet().toList());
      missingItemList.add(model);
      emit(MissingItemListLoad(missingItemList.toSet().toList()!));
    }
  }

  void removeMissingItem(IngredientModel model) {
    List<IngredientModel> value = missingItemList.where((element) => element.hashCode == model.hashCode).toList();
    if (value.isNotEmpty) {
      previousMissingItemList.add(missingItemList.toSet().toList());
      missingItemList.remove(model);
      emit(MissingItemListLoad(missingItemList.toSet().toList()!));
    }
  }

  void addItemToMyFrizeList(IngredientModel model) {
    List<IngredientModel> value = myFrizeItemList.where((element) => element.hashCode == model.hashCode).toList();
    if (value.isEmpty) {
      previousMyFrizeItemList.add(myFrizeItemList.toSet().toList());
      bool isContainTitle = false;
      IngredientModel? containModel;
      for (var item in myFrizeItemList) {
        if (item.title!.toLowerCase() == model.title!.toLowerCase()) {
          isContainTitle = true;
          containModel = item;
          break;
        }
      }
      if (isContainTitle == true) {
        IngredientModel newElement = IngredientModel(title: model.title, imagePath: model.imagePath, color: model.color, quantity: ((model.quantity ?? 0) + (containModel!.quantity ?? 0)));
        //quantity: ((model.quantity ?? 0) + (containModel!.quantity ?? 0)));//quantity: model.quantity

        int index = myFrizeItemList.indexOf(containModel!);
        myFrizeItemList[index] = newElement;
        emit(MyFrizeListLoad(myFrizeItemList.toSet().toList()));
      } else {
        myFrizeItemList.add(model);
        emit(MyFrizeListLoad(myFrizeItemList.toSet().toList()));
      }
    }
  }

  void removeMyFrizeItem(IngredientModel model) {
    List<IngredientModel> value = myFrizeItemList.where((element) => element.hashCode == model.hashCode).toList();
    if (value.isNotEmpty) {
      previousMyFrizeItemList.add(myFrizeItemList.toSet().toList());
      myFrizeItemList.remove(model);
      emit(MyFrizeListLoad(myFrizeItemList.toSet().toList()!));
    }
  }

  void missingItemLoad(List<IngredientModel> missingItems) {
    missingItemList = missingItems;
    emit(MissingItemListLoad(missingItemList.toSet().toList()));
  }

  void calculateMissingItemList(RecipeModel recipeModel, List<IngredientModel> myFrizeList) {
    missingItemList.clear();

    for (var myFrizeIngredient in myFrizeList) {
      for (var recipeIngredient in recipeModel.ingredients!) {
        List<IngredientModel>? value = myFrizeList.where((element) => element.title!.toLowerCase() == recipeIngredient.title!.toLowerCase()).toList();
        if (!missingItemList.contains(recipeIngredient) && value.isEmpty) {
          //!missingItemList.contains(recipeIngredient) bu kontrol aynı  malzemenin döngüde tekrar eklenmemesi için konuldu
          missingItemList.add(recipeIngredient);
        } else if ((!missingItemList.contains(recipeIngredient)) && (myFrizeIngredient.title!.toLowerCase() == recipeIngredient.title!.toLowerCase()) && ((myFrizeIngredient.quantity?.toDouble() ?? 0) < (recipeIngredient.quantity?.toDouble() ?? 0))) {
          missingItemList.add(recipeIngredient);
        }
      }
    }
    missingItemLoad(missingItemList);
  }

  void myFrizeListLoad() {
    emit(MyFrizeListLoad(myFrizeItemList.toSet().toList()!));
  }

  void missingItemDragging(bool isDragging) {
    missingItemIsDragging = isDragging;
    emit(MissingItemDragging(missingItemIsDragging!));
  }

  void myFrizeItemDragging(bool isDragging) {
    myFrizeItemIsDragging = isDragging;
    emit(MyFrizeItemDragging(myFrizeItemIsDragging!));
  }

  BuildContext? context;

  void setContext(BuildContext context) => this.context = context;
}
