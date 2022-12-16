import 'dart:core';

import 'package:recipe_finder/product/model/ingradient_model.dart';

enum MaterialSearchCategory {
  essentials,
  vegatables,
  fruits,
}

class MaterialSearchModel {
  final Map<MaterialSearchCategory, List<IngredientModel>> materialSearchMap;

  MaterialSearchModel({required this.materialSearchMap});
}
