import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:vexana/vexana.dart';

import '../ingredient_quantity/ingredient_quantity.dart';

part 'ingredients_of_category_model.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class IngredientsOfCategoryModel extends HiveObject implements INetworkModel<IngredientsOfCategoryModel> {
  @JsonKey(name: 'data')
  @HiveField(0)
  final List<IngredientQuantity>? ingredientList;

  IngredientsOfCategoryModel({this.ingredientList});

  @override
  factory IngredientsOfCategoryModel.fromJson(Map<String, dynamic> json) => _$IngredientsOfCategoryModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$IngredientsOfCategoryModelToJson(this);

  @override
  IngredientsOfCategoryModel fromJson(Map<String, dynamic> json) {
    return _$IngredientsOfCategoryModelFromJson(json);
  }
}
