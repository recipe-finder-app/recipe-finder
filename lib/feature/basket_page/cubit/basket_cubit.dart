import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/base/model/base_view_model.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/product/service/common_service.dart';
import 'package:recipe_finder/product/utils/constant/image_path_enum.dart';
import 'package:recipe_finder/feature/basket_page/cubit/basket_state.dart';
import 'package:recipe_finder/feature/basket_page/service/basket_service.dart';
import 'package:recipe_finder/product/model/recipe/recipe.dart';

import '../../../core/init/cache/hive_manager.dart';
import '../../../product/model/ingredient_quantity/ingredient_quantity.dart';
import '../../../product/model/user/user_model.dart';
import '../../../product/utils/enum/hive_enum.dart';

class BasketCubit extends Cubit<BasketState> implements IBaseViewModel {
 late IBasketService service;
 late ICommonService commonService;
  late List<Recipe> basketRecipeItems = [
    Recipe(
      imagePath: 'asset/png/foot2.png',
      nameEN: 'Deneme Text 1',
      ingredients: [
        IngredientQuantity(nameEN: 'egg', imageUrl: ImagePathConstant.egg.path, quantity: 5),
        IngredientQuantity(nameEN: 'milk', imageUrl: ImagePathConstant.milk.path, quantity: 6),
        IngredientQuantity(nameEN: 'bread', imageUrl: ImagePathConstant.bread.path, quantity: 3),
        IngredientQuantity(nameEN: 'salad', imageUrl: ImagePathConstant.salad.path, quantity: 2),
        IngredientQuantity(nameEN: 'chicken', imageUrl: ImagePathConstant.chicken.path, quantity: 4),
      ],
    ),
    Recipe(
      imagePath: 'asset/png/foot1.png',
      nameEN: 'Deneme Text 2',
      ingredients: [
        IngredientQuantity(nameEN: 'Egg', quantity: 4),
        IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
        IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
        IngredientQuantity(nameEN: 'Egg', quantity: 4),
        IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
        IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
      ],
    ),
    Recipe(
      imagePath: 'asset/png/foot2.png',
      nameEN: 'Deneme Text 3',
      ingredients: [
        IngredientQuantity(nameEN: 'Egg', imageUrl: ImagePathConstant.egg.path, quantity: 4),
        IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
        IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
      ],
    ),
  ];

  BasketCubit() : super(const BasketState(basketRecipeItemList: [], myFrizeList: []));

  @override
  Future<void> init() async {
    service = BasketService();
    commonService = CommonService();
   await setMyFrizeItemList();
  }

  void addItemFromBasketRecipeList(Recipe model) {
    basketRecipeItems.add(model);
    emit(state.copyWith(basketRecipeItemList: basketRecipeItems));
    //emit(BasketRecipeItemListLoad(basketRecipeItems.toSet().toList()));
   
  }

  void deletedItemFromBasketRecipeList(Recipe model) {
    basketRecipeItems.remove(model);
    emit(state.copyWith(basketRecipeItemList: basketRecipeItems));
   //emit(BasketRecipeItemListLoad(basketRecipeItems.toSet().toList()));
  }

  void changeSelectedCardModel(Recipe? model) {
    if (state.selectedRecipe == model) {
       emit(state.copyWith(selectedRecipe:  Recipe())); // null vermek yerine recipe verip id yoksa kontrolü yapılmalı.state'de copy with olduğundan null değer atanmıyor.
     
     // emit(ChangeSelectedCardModel(selectedCardModel));
    } else {
     emit(state.copyWith(selectedRecipe: model));
     // emit(ChangeSelectedCardModel(selectedCardModel));
    }
    
  }

  void changeSelectedColorIndex(int? index) {
    if (state.selectedColorIndex == index) {
      emit(state.copyWith(selectedColorIndex: -1));
    } else {
       emit(state.copyWith(selectedColorIndex: index));
     //emit(ChangeSelectedColorIndex(selectedColorIndex));
    }

  }

  Color selectedCardItemColor(int index) {
    if (index == state.selectedColorIndex) {
      return ColorConstants.instance.oriolesOrange;
    } else {
      return ColorConstants.instance.russianViolet;
    }
  }
  Future<void> setMyFrizeItemList() async {
   final frizeList = await fetchMyFrizeItemList();
   emit(state.copyWith(myFrizeList: frizeList));
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
  @override
  void dispose() {
  }

  @override
  BuildContext? context;

  @override
  void setContext(BuildContext context) => this.context = context;
}
