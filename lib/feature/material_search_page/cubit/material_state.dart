import 'package:recipe_finder/product/model/ingradient_model.dart';

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
  List<IngredientModel>? essentialList;
  EssentialListLoaded(this.essentialList);
}

class VegatableListLoaded extends IMaterialSearchState {
  List<IngredientModel>? vegatablealList;
  VegatableListLoaded(this.vegatablealList);
}
