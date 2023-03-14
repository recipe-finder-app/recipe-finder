import 'dart:core';

import 'package:recipe_finder/product/model/ingradient_model.dart';
import 'package:recipe_finder/product/model/ingredient_category/ingredient_category_model.dart';

class MaterialSearchModel {
  final Map<IngredientCategoryModel, List<IngredientModel>> materialSearchMap;

  MaterialSearchModel({required this.materialSearchMap});
}
