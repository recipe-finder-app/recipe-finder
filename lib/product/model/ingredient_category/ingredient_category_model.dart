import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'ingredient_category_model.g.dart';

@JsonSerializable()
class IngredientCategoryModel extends INetworkModel<IngredientCategoryModel> {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'name')
  final String? categoryName;

  IngredientCategoryModel({this.id, this.categoryName});

  @override
  factory IngredientCategoryModel.fromJson(Map<String, dynamic> json) => _$IngredientCategoryModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$IngredientCategoryModelToJson(this);

  @override
  IngredientCategoryModel fromJson(Map<String, dynamic> json) {
    return _$IngredientCategoryModelFromJson(json);
  }
}

@JsonSerializable(explicitToJson: true)
class IngredientCategoryListModel extends INetworkModel<IngredientCategoryListModel> {
  @JsonKey(name: 'data')
  final List<IngredientCategoryModel>? ingredientCategoryList;
  final bool? success;

  IngredientCategoryListModel({this.ingredientCategoryList, this.success});

  @override
  factory IngredientCategoryListModel.fromJson(Map<String, dynamic> json) => _$IngredientCategoryListModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$IngredientCategoryListModelToJson(this);

  @override
  IngredientCategoryListModel fromJson(Map<String, dynamic> json) {
    return _$IngredientCategoryListModelFromJson(json);
  }
}
