import 'package:hive_flutter/adapters.dart';

import '../../../product/model/ingredient/ingredient_model.dart';
import '../../../product/model/ingredient_category/category_of_ingredient_model.dart';

part 'material_search_model.g.dart';

@HiveType(typeId: 5)
class MaterialSearchModel extends HiveObject {
  @HiveField(0)
  final Map<CategoryOfIngredientModel, List<IngredientModel>>? materialSearchMap;

  MaterialSearchModel({this.materialSearchMap});
}
