import '../../../product/model/ingradient_model.dart';
import '../model/like_recipe_model.dart';

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
  late List<LikeRecipeModel> likesRecipeItemList;
  LikesRecipeItemListLoad(this.likesRecipeItemList);
}

class MissingItemListTargetState extends ILikesState {
  late bool targetState;
  MissingItemListTargetState(this.targetState);
}

class MyFrizeItemTargetState extends ILikesState {
  late bool targetState;
  MyFrizeItemTargetState(this.targetState);
}

class MissingItemListLoad extends ILikesState {
  late List<IngredientModel> missingItemList;
  MissingItemListLoad(this.missingItemList);
}

class MyFrizeListLoad extends ILikesState {
  late List<IngredientModel> myFrizeList;
  MyFrizeListLoad(this.myFrizeList);
}

class LikesError extends ILikesState {
  String errorMessage;
  LikesError(this.errorMessage);
}
