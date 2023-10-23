
import '../../../product/model/ingredient_category/category_of_ingredient_model.dart';
import '../../../product/model/ingredient_quantity/ingredient_quantity.dart';

abstract class IMaterialSearchState {
  IMaterialSearchState();
}

class MaterialSearchInit extends IMaterialSearchState {
  MaterialSearchInit();
}

class OnMaterialSearchLoading extends IMaterialSearchState {
  final bool? isLoading;
  OnMaterialSearchLoading({this.isLoading});
}

class MaterialSearchError extends IMaterialSearchState {
  String errorMessage;
  MaterialSearchError(this.errorMessage);
}

class IngredientListLoad extends IMaterialSearchState {
  Map<CategoryOfIngredientModel, List<IngredientQuantity>>? materialSearchMap;
  IngredientListLoad(this.materialSearchMap);
}

class SearchedIngredientListLoad extends IMaterialSearchState {
  Map<CategoryOfIngredientModel, List<IngredientQuantity>>? searchedMap;
  SearchedIngredientListLoad(this.searchedMap);
}
