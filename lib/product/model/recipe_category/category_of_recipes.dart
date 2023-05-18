import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'category_of_recipes.g.dart';

@JsonSerializable()
@HiveType(typeId: 6)
class CategoryOfRecipesModel extends HiveObject implements INetworkModel<CategoryOfRecipesModel> {
  @JsonKey(name: '_id')
  @HiveField(0)
  final String? id;

  @JsonKey(name: 'name')
  @HiveField(1)
  final String? categoryName;

  @JsonKey(name: 'color')
  @HiveField(2)
  final int? color;

  @JsonKey(name: 'imagePath')
  @HiveField(3)
  final String? imagePath;

  CategoryOfRecipesModel({this.id, this.categoryName, this.color, this.imagePath});

  @override
  factory CategoryOfRecipesModel.fromJson(Map<String, dynamic> json) => _$CategoryOfRecipesModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryOfRecipesModelToJson(this);

  @override
  CategoryOfRecipesModel fromJson(Map<String, dynamic> json) {
    return _$CategoryOfRecipesModelFromJson(json);
  }
}

@JsonSerializable(explicitToJson: true)
class CategoryOfRecipesListModel extends INetworkModel<CategoryOfRecipesListModel> {
  @JsonKey(name: 'data')
  final List<CategoryOfRecipesModel>? recipeCategoryList;
  final bool? success;

  CategoryOfRecipesListModel({this.recipeCategoryList, this.success});

  @override
  factory CategoryOfRecipesListModel.fromJson(Map<String, dynamic> json) => _$CategoryOfRecipesListModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryOfRecipesListModelToJson(this);

  @override
  CategoryOfRecipesListModel fromJson(Map<String, dynamic> json) {
    return _$CategoryOfRecipesListModelFromJson(json);
  }
}
