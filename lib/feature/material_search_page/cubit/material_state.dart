import 'package:recipe_finder/feature/material_search_page/model/product_model.dart';

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

class EssentialListLoaded extends IMaterialSearchState {
  List<ProductModel>? essentialList;
  EssentialListLoaded(this.essentialList);
}

class VegatableListLoaded extends IMaterialSearchState {
  List<ProductModel>? vegatablealList;
  VegatableListLoaded(this.vegatablealList);
}
