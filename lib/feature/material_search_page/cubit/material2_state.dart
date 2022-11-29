import '../../../product/model/ingradient_model.dart';
import '../model/material2_model.dart';

abstract class IMaterialSearch2State {
  IMaterialSearch2State();
}

class MaterialSearch2Init extends IMaterialSearch2State {
  MaterialSearch2Init();
}

class OnMaterialSearch2Loading extends IMaterialSearch2State {
  late bool isLoading;
  OnMaterialSearch2Loading(isLoading);
}

class MaterialSearch2Error extends IMaterialSearch2State {
  String errorMessage;
  MaterialSearch2Error(this.errorMessage);
}

class IngredientListLoad extends IMaterialSearch2State {
  Map<MaterialSearchCategory, List<IngredientModel>> materialSearchMap;
  IngredientListLoad(this.materialSearchMap);
}
