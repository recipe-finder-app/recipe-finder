import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/base/model/base_view_model.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/product/utils/constant/image_path_enum.dart';
import 'package:recipe_finder/feature/basket_page/cubit/basket_state.dart';
import 'package:recipe_finder/feature/basket_page/service/basket_service.dart';
import 'package:recipe_finder/product/model/recipe/recipe.dart';

import '../../../product/model/ingredient_quantity/ingredient_quantity.dart';

class BasketCubit extends Cubit<IBasketState> implements IBaseViewModel {
  IBasketService? service;
  Recipe? selectedCardModel;

  late List<Recipe> basketRecipeItems = [
    Recipe(
      imagePath: 'asset/png/foot2.png',
      nameEN: 'Deneme Text 1',
      ingredients: [
        IngredientQuantity(nameEN: 'egg', imagePath: ImagePathConstant.egg.path, quantity: 5),
        IngredientQuantity(nameEN: 'milk', imagePath: ImagePathConstant.milk.path, quantity: 6),
        IngredientQuantity(nameEN: 'bread', imagePath: ImagePathConstant.bread.path, quantity: 3),
        IngredientQuantity(nameEN: 'salad', imagePath: ImagePathConstant.salad.path, quantity: 2),
        IngredientQuantity(nameEN: 'chicken', imagePath: ImagePathConstant.chicken.path, quantity: 4),
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
        IngredientQuantity(nameEN: 'Egg', imagePath: ImagePathConstant.egg.path, quantity: 4),
        IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
        IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
      ],
    ),
  ];

  BasketCubit() : super(BasketsInit());
  late List<IngredientQuantity> myFinderFrizeItems;

  int? selectedColorIndex;
  @override
  void init() {
    selectedCardModel = null;
    selectedColorIndex = null;
    service = BasketService();
    myFinderFrizeItems = [
      IngredientQuantity(nameEN: 'milk', imagePath: ImagePathConstant.milk.path, quantity: 6),
      IngredientQuantity(nameEN: 'bread', imagePath: ImagePathConstant.bread.path, quantity: 3),
      IngredientQuantity(nameEN: 'salad', imagePath: ImagePathConstant.salad.path, quantity: 2),
      IngredientQuantity(nameEN: 'egg', imagePath: ImagePathConstant.egg.path, quantity: 3),
      IngredientQuantity(nameEN: 'potato', imagePath: ImagePathConstant.potato.path, quantity: 2),
      IngredientQuantity(nameEN: 'chicken', imagePath: ImagePathConstant.chicken.path, quantity: 2),
    ];
  }

  void addItemFromBasketRecipeList(Recipe model) {
    basketRecipeItems.add(model);
    emit(BasketRecipeItemListLoad(basketRecipeItems.toSet().toList()));
   
  }

  void deletedItemFromBasketRecipeList(Recipe model) {
    basketRecipeItems.remove(model);
    emit(BasketRecipeItemListLoad(basketRecipeItems.toSet().toList()));
  }

  void changeSelectedCardModel(Recipe? model) {
    if (selectedCardModel == model) {
      selectedCardModel = null;
      emit(ChangeSelectedCardModel(selectedCardModel));
    } else {
      selectedCardModel = model;
      emit(ChangeSelectedCardModel(selectedCardModel));
    }
  }

  void changeSelectedColorIndex(int? index) {
    if (selectedColorIndex == index) {
      selectedColorIndex = null;
      emit(ChangeSelectedColorIndex(selectedColorIndex));
    } else {
      selectedColorIndex = index;
      emit(ChangeSelectedColorIndex(selectedColorIndex));
    }

  }

  Color selectedCardItemColor(int index) {
    if (index == selectedColorIndex) {
      return ColorConstants.instance.oriolesOrange;
    } else {
      return ColorConstants.instance.russianViolet;
    }
  }

  @override
  void dispose() {
    selectedCardModel = null;
    selectedColorIndex = null;
  }

  @override
  BuildContext? context;

  @override
  void setContext(BuildContext context) => this.context = context;
}
