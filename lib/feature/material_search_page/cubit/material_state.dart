import '../../../product/model/ingredient/ingredient_model.dart';
import '../../../product/model/ingredient_category/category_of_ingredient_model.dart';

abstract class IMaterialSearchState {
  IMaterialSearchState();
}

class MaterialSearchInit extends IMaterialSearchState {
  MaterialSearchInit();
}

class OnMaterialSearchLoading extends IMaterialSearchState {
  late bool isLoading;
  OnMaterialSearchLoading(isLoading);
}

class MaterialSearchError extends IMaterialSearchState {
  String errorMessage;
  MaterialSearchError(this.errorMessage);
}

class IngredientListLoad extends IMaterialSearchState {
  Map<CategoryOfIngredientModel, List<IngredientModel>>? materialSearchMap;
  IngredientListLoad(this.materialSearchMap);
}

class SearchedIngredientListLoad extends IMaterialSearchState {
  Map<CategoryOfIngredientModel, List<IngredientModel>>? searchedMap;
  SearchedIngredientListLoad(this.searchedMap);
}
