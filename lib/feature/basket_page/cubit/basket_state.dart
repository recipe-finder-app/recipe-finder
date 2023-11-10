import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_finder/product/model/error_model.dart';
import 'package:recipe_finder/product/model/recipe/recipe.dart';

import '../../../product/model/ingredient_quantity/ingredient_quantity.dart';


class BasketState extends Equatable {
   const BasketState({
    required this.basketRecipeItemList,
    required this.myFrizeList,
    this.selectedRecipe,
    this.selectedColorIndex,
    this.error
  });

final  List<Recipe> basketRecipeItemList;
final  List<IngredientQuantity> myFrizeList;
final  Recipe? selectedRecipe;
final  int? selectedColorIndex;
final  BaseError? error;
  BasketState copyWith({
    List<Recipe>? basketRecipeItemList,
    List<IngredientQuantity>? myFrizeList,
    Recipe? selectedRecipe,
    int? selectedColorIndex,
    BaseError? error    
  }) {
    return BasketState(
          basketRecipeItemList: basketRecipeItemList ?? this.basketRecipeItemList,
      myFrizeList: myFrizeList ?? this.myFrizeList,
      selectedRecipe: selectedRecipe ?? this.selectedRecipe,
      selectedColorIndex: selectedColorIndex ?? this.selectedColorIndex,
      error: error ?? this.error
    );
  }

@override
List<Object?> get props => [basketRecipeItemList, myFrizeList, selectedRecipe, selectedColorIndex, error];
}
abstract class IBasketState {
  IBasketState();
}

class BasketsInit extends IBasketState {
  BasketsInit();
}

class OnBasketLoading extends IBasketState {
  late bool isLoading;
  OnBasketLoading(this.isLoading);
}

class BasketRecipeItemListLoad extends IBasketState {
  late List<Recipe> basketRecipeItemList;
  BasketRecipeItemListLoad(this.basketRecipeItemList);
}

class MyFrizeListLoad extends IBasketState {
  late List<IngredientQuantity> myFrizeList;
  MyFrizeListLoad(this.myFrizeList);
}

class ChangeSelectedCardModel extends IBasketState {
  Recipe? model;
  ChangeSelectedCardModel(this.model);
}

class ChangeSelectedColorIndex extends IBasketState {
  int? index;
  ChangeSelectedColorIndex(this.index);
}

class BasketsError extends IBasketState {
  String errorMessage;
  BasketsError(this.errorMessage);
}
