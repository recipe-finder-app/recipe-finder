import 'package:recipe_finder/product/model/recipe_model.dart';

abstract class IDiscoverState {
  IDiscoverState();
}

class DiscoverInit extends IDiscoverState {
  DiscoverInit();
}

class DiscoverLoading extends IDiscoverState {
  late bool isLoading;
  DiscoverLoading(isLoading);
}

class ChangeSelectedCategoryIndex extends IDiscoverState {
  int? index;
  ChangeSelectedCategoryIndex(this.index);
}


class DiscoverRecipeItemListLoad extends IDiscoverState {
  late List<RecipeModel> discoverRecipeItemList;
  DiscoverRecipeItemListLoad(this.discoverRecipeItemList);
}
class DiscoverError extends IDiscoverState {
  String errorMessage;
  DiscoverError(this.errorMessage);
}
