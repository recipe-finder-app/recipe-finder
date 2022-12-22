import 'package:recipe_finder/feature/likes_page/model/like_recipe_model.dart';
import 'package:recipe_finder/product/model/recipe_model.dart';

import '../../../product/model/ingradient_model.dart';

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
  late List<RecipeModel> basketRecipeItemList;
  BasketRecipeItemListLoad(this.basketRecipeItemList);
}


class MyFrizeListLoad extends IBasketState {
  late List<IngredientModel> myFrizeList;
  MyFrizeListLoad(this.myFrizeList);
}

class ChangeSelectedCardModel extends IBasketState {
  late RecipeModel model;
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
