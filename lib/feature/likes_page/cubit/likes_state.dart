import '../../../product/model/ingradient_model.dart';

abstract class ILikesState {
  ILikesState();
}

class LikesInit extends ILikesState {
  LikesInit();
}

class OnLikesLoading extends ILikesState {
  late bool isLoading;
  OnLikesLoading(isLoading);
}

class UpdateIngredientList extends ILikesState {
  late List<IngredientModel> myList;
  UpdateIngredientList(this.myList);
}

class LikesError extends ILikesState {
  String errorMessage;
  LikesError(this.errorMessage);
}
