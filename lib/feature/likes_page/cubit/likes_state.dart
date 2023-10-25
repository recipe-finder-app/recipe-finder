import 'package:recipe_finder/product/model/recipe/recipe.dart';

abstract class ILikesState {
  ILikesState();
}

class LikesInit extends ILikesState {
  LikesInit();
}

class OnLikesLoading extends ILikesState {
  late bool isLoading;
  OnLikesLoading(this.isLoading);
}

class LikesRecipeItemListLoad extends ILikesState {
  late List<Recipe> likesRecipeItemList;
  LikesRecipeItemListLoad(this.likesRecipeItemList);
}

class LikesError extends ILikesState {
  String errorMessage;
  LikesError(this.errorMessage);
}
