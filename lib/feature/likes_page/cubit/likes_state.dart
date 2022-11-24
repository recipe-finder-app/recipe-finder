import '../../../product/model/ingradient_model.dart';

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
