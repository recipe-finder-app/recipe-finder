import '../../../product/model/ingradient_model.dart';

abstract class IRecipeDetailState {
  IRecipeDetailState();
}

class RecipeDetailInit extends IRecipeDetailState {
  RecipeDetailInit();
}

class MyFrizeListLoading extends IRecipeDetailState {
  late bool isLoading;
  MyFrizeListLoading(isLoading);
}

class MyFrizeListLoad extends IRecipeDetailState {
  late List<IngredientModel> myFrizeList;
  MyFrizeListLoad(this.myFrizeList);
}

class ChangeVideoPlayerState extends IRecipeDetailState {
  late Future<void> controller;
  ChangeVideoPlayerState(this.controller);
}

class RecipeDetailError extends IRecipeDetailState {
  String errorMessage;
  RecipeDetailError(this.errorMessage);
}
