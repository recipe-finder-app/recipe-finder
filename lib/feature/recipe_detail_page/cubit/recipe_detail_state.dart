import 'package:chewie/chewie.dart';

import '../../../product/model/ingredient/ingredient_model.dart';

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

class ChangeSelectedTabBarIndex extends IRecipeDetailState {
  int? index;
  ChangeSelectedTabBarIndex(this.index);
}

class ChangePreviousClickedTabBarIndex extends IRecipeDetailState {
  int? index;
  ChangePreviousClickedTabBarIndex(this.index);
}

class ChangeVideoPlayerModeState extends IRecipeDetailState {
  late ChewieController controller;
  ChangeVideoPlayerModeState(this.controller);
}

class RecipeDetailError extends IRecipeDetailState {
  String errorMessage;
  RecipeDetailError(this.errorMessage);
}
