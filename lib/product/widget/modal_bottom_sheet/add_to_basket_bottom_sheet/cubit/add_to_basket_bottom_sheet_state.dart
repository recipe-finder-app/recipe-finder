
import '../../../../model/ingredient_quantity/ingredient_quantity.dart';

abstract class IAddToBasketState {
  IAddToBasketState();
}

class AddToBasketInit extends IAddToBasketState {
  AddToBasketInit();
}

class AddToBasketLoading extends IAddToBasketState {
  late bool isLoading;
  AddToBasketLoading(this.isLoading);
}

class MissingItemListLoad extends IAddToBasketState {
  late List<IngredientQuantity> missingItemList;
  MissingItemListLoad(this.missingItemList);
}

class MissingItemDragging extends IAddToBasketState {
  late bool isDragging;
  MissingItemDragging(this.isDragging);
}

class MyFrizeListLoad extends IAddToBasketState {
  late List<IngredientQuantity> myFrizeItemList;
  MyFrizeListLoad(this.myFrizeItemList);
}

class MyFrizeItemDragging extends IAddToBasketState {
  late bool isDragging;
  MyFrizeItemDragging(this.isDragging);
}

class AddToBasketError extends IAddToBasketState {
  String errorMessage;
  AddToBasketError(this.errorMessage);
}
