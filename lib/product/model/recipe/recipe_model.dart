import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:recipe_finder/product/model/ingredient/ingredient_model.dart';
import 'package:vexana/vexana.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 7)
class RecipeModel extends HiveObject implements INetworkModel<RecipeModel> {
  final String? imagePath;
  final String? directions;
  final String? videoPath;
  final List<IngredientModel>? ingredients;
  @JsonKey(name: '_id')
  @HiveField(0)
  final String? id;

  @JsonKey(name: 'name')
  @HiveField(1)
  final String? title;

  @JsonKey(name: 'description')
  @HiveField(2)
  final String? description;

  @JsonKey(name: 'categoryId')
  @HiveField(3)
  final String? categoryId;

  RecipeModel({this.id, this.title, this.description, this.categoryId, this.imagePath, this.directions, this.videoPath, this.ingredients});

  @override
  factory RecipeModel.fromJson(Map<String, dynamic> json) => _$RecipeModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RecipeModelToJson(this);

  @override
  RecipeModel fromJson(Map<String, dynamic> json) {
    return _$RecipeModelFromJson(json);
  }
}

@JsonSerializable(explicitToJson: true)
class RecipeListModel extends INetworkModel<RecipeListModel> {
  @JsonKey(name: 'data')
  final List<RecipeModel>? recipeList;
  final bool? success;

  RecipeListModel({this.recipeList, this.success});

  @override
  factory RecipeListModel.fromJson(Map<String, dynamic> json) => _$RecipeListModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RecipeListModelToJson(this);

  @override
  RecipeListModel fromJson(Map<String, dynamic> json) {
    return _$RecipeListModelFromJson(json);
  }
}
