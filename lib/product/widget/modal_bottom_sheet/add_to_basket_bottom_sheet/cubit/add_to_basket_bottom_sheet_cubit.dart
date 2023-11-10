import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/product/service/common_service.dart';
import 'package:recipe_finder/product/widget/modal_bottom_sheet/add_to_basket_bottom_sheet/cubit/add_to_basket_bottom_sheet_state.dart';

import '../../../../../core/init/cache/hive_manager.dart';
import '../../../../model/ingredient_quantity/ingredient_quantity.dart';
import '../../../../model/user/user_model.dart';
import '../../../../utils/constant/image_path_enum.dart';
import '../../../../model/recipe/recipe.dart';
import '../../../../utils/enum/hive_enum.dart';

class AddToBasketCubit extends Cubit<IAddToBasketState> {
  bool? missingItemIsDragging;
  bool? myFrizeItemIsDragging;
  List<IngredientQuantity> currentMyFrizeItemList = [];
  List<IngredientQuantity> currentMissingItemList = [];

  List<List<IngredientQuantity>> previousMissingItemList = [];
  List<List<IngredientQuantity>> previousMyFrizeItemList = [];

  List<IngredientQuantity> initialMissingItemList = [];
  List<IngredientQuantity> initialMyFrizeItemList = [];
  ICommonService commonService = CommonService();
  AddToBasketCubit() : super(AddToBasketInit());

  Future<void> setFirstItemLists(List<IngredientQuantity> missingList) async {
    initialMissingItemList.clear();
    initialMyFrizeItemList.clear();
    final myFrizeList = await fetchMyFrizeItemList();
    initialMissingItemList.addAll(missingList.toSet().toList()); //burayı addAll ile yapmak önemli.İki listeyi birbirine eşitleyince bu methodu birkere çalıştırsanda yine de son haline eşit oluyor.Referans tipi muhabbeti.Böyle olunca sıkıntı olmuyor.
    initialMyFrizeItemList.addAll(myFrizeList.toSet().toList());
  }

  void undoAll() {
    currentMissingItemList.clear();
    currentMyFrizeItemList.clear();
    currentMissingItemList.addAll(initialMissingItemList.toSet().toList());
    currentMyFrizeItemList.addAll(initialMyFrizeItemList.toSet().toList());
    missingItemLoad(currentMissingItemList);
    myFrizeListLoad();
  }

  void undo() {
    if (previousMissingItemList.isNotEmpty) {
      currentMissingItemList.clear();
      currentMissingItemList.addAll(previousMissingItemList.last.toSet().toList());
      previousMissingItemList.removeLast();
      missingItemLoad(currentMissingItemList);
    }
    if (previousMyFrizeItemList.isNotEmpty) {
      currentMyFrizeItemList.clear();
      currentMyFrizeItemList.addAll(previousMyFrizeItemList.last.toSet().toList());
      previousMyFrizeItemList.removeLast();
      myFrizeListLoad();
    }
  }

  void addItemToMissingList(IngredientQuantity model) {
    List<IngredientQuantity> value = currentMissingItemList.where((element) => element.hashCode == model.hashCode).toList();
    if (value.isEmpty) {
      previousMissingItemList.add(currentMissingItemList.toSet().toList());
      currentMissingItemList.add(model);
      emit(MissingItemListLoad(currentMissingItemList.toSet().toList()!));
    }
  }

  void removeMissingItem(IngredientQuantity model) {
    List<IngredientQuantity> value = currentMissingItemList.where((element) => element.hashCode == model.hashCode).toList();
    if (value.isNotEmpty) {
      previousMissingItemList.add(currentMissingItemList.toSet().toList());
      currentMissingItemList.remove(model);
      emit(MissingItemListLoad(currentMissingItemList.toSet().toList()!));
    }
  }

  void addItemToMyFrizeList(IngredientQuantity model) {
    List<IngredientQuantity> value = currentMyFrizeItemList.where((element) => element.hashCode == model.hashCode).toList();
    if (value.isEmpty) {
      previousMyFrizeItemList.add(currentMyFrizeItemList.toSet().toList());
      bool isContainTitle = false;
      IngredientQuantity? containModel;
      for (var item in currentMyFrizeItemList) {
        if (item.nameEN!.toLowerCase() == model.nameEN!.toLowerCase()) {
          isContainTitle = true;
          containModel = item;
          break;
        }
      }
      if (isContainTitle == true) {
        IngredientQuantity newElement = IngredientQuantity(nameEN: model.nameEN, imageUrl: model.imageUrl, color: model.color, quantity: ((model.quantity ?? 0) + (containModel!.quantity ?? 0)));
        //quantity: ((model.quantity ?? 0) + (containModel!.quantity ?? 0)));//quantity: model.quantity

        int index = currentMyFrizeItemList.indexOf(containModel!);
        currentMyFrizeItemList[index] = newElement;
        emit(MyFrizeListLoad(currentMyFrizeItemList.toSet().toList()));
      } else {
        currentMyFrizeItemList.add(model);
        emit(MyFrizeListLoad(currentMyFrizeItemList.toSet().toList()));
      }
    }
  }

  void removeMyFrizeItem(IngredientQuantity model) {
    List<IngredientQuantity> value = currentMyFrizeItemList.where((element) => element.hashCode == model.hashCode).toList();
    if (value.isNotEmpty) {
      previousMyFrizeItemList.add(currentMyFrizeItemList.toSet().toList());
      currentMyFrizeItemList.remove(model);
      emit(MyFrizeListLoad(currentMyFrizeItemList.toSet().toList()!));
    }
  }

  void missingItemLoad(List<IngredientQuantity> missingItems) {
    currentMissingItemList = missingItems;
    emit(MissingItemListLoad(currentMissingItemList.toSet().toList()));
  }

  void calculateMissingItemList(Recipe recipeModel, List<IngredientQuantity> myFrizeList) {
    currentMissingItemList.clear();

    for (var myFrizeIngredient in myFrizeList) {
      for (var recipeIngredient in recipeModel.ingredients!) {
        List<IngredientQuantity>? value = myFrizeList.where((element) => element.nameEN!.toLowerCase() == recipeIngredient.nameEN!.toLowerCase()).toList();
        if (!currentMissingItemList.contains(recipeIngredient) && value.isEmpty) {
          //!missingItemList.contains(recipeIngredient) bu kontrol aynı  malzemenin döngüde tekrar eklenmemesi için konuldu
          currentMissingItemList.add(recipeIngredient);
        } else if ((!currentMissingItemList.contains(recipeIngredient)) && (myFrizeIngredient.nameEN!.toLowerCase() == recipeIngredient.nameEN!.toLowerCase()) && ((myFrizeIngredient.quantity?.toDouble() ?? 0) < (recipeIngredient.quantity?.toDouble() ?? 0))) {
          currentMissingItemList.add(recipeIngredient);
        }
      }
    }
    missingItemLoad(currentMissingItemList);
  }

  Future<List<IngredientQuantity>> fetchMyFrizeItemList()async {
    try{
     IHiveManager<UserModel> hiveManager = HiveManager<UserModel>(HiveBoxEnum.userModel);
 final user = await hiveManager.get(HiveKeyEnum.user);
 if(user?.id!=null){
 final frizeList = await  commonService.fetchAllFrizeItemList(user!.id!);
    return frizeList;
 }
 else {
  return [];
 }
    }
    catch(e){
      throw Exception(e.toString());
  }
  }
  void myFrizeListLoad() {
    emit(MyFrizeListLoad(currentMyFrizeItemList.toSet().toList()!));
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
