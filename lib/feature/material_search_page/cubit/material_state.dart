import '../../../product/model/ingradient_model.dart';
import '../model/material_model.dart';

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
  Map<MaterialSearchCategory, List<IngredientModel>>? materialSearchMap;
  IngredientListLoad(this.materialSearchMap);
}

class SearchedIngredientListLoad extends IMaterialSearchState {
  Map<MaterialSearchCategory, List<IngredientModel>>? searchedMap;
  SearchedIngredientListLoad(this.searchedMap);
}
