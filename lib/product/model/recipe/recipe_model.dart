import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

import '../ingredient_quantity/ingredient_quantity.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 7)
class Recipe extends HiveObject with EquatableMixin implements INetworkModel<Recipe> {

  @JsonKey(name: 'id')
  @HiveField(0)
  final String? id;

  @JsonKey(name: 'name_en')
  @HiveField(1)
  final String? nameEN;

  @JsonKey(name: 'name_tr')
  @HiveField(2)
  final String? nameTR;

@JsonKey(name: 'category_id')
  @HiveField(3)
  final String? categoryId;

  @JsonKey(name: 'category_name_en')
  @HiveField(4)
  final String? categoryNameEN;

  @JsonKey(name: 'category_name_tr')
  @HiveField(5)
  final String? categoryNameTR;

  @JsonKey(name: 'description_en')
  @HiveField(6)
  final String? descriptionEN;

  @JsonKey(name: 'description_tr')
  @HiveField(7)
  final String? descriptionTR;

  @JsonKey(name: 'directions_en')
  @HiveField(8)
   final String? directionsEN;

@JsonKey(name: 'directions_tr')
  @HiveField(9)
   final String? directionsTR;

@JsonKey(name: 'image_url')
  @HiveField(10)
   final String? imagePath;

 
  final String? videoPath;
  final List<IngredientQuantity>? ingredients;
    Recipe({
    this.id,
    this.nameEN,
    this.nameTR,
    this.categoryId,
    this.categoryNameEN,
    this.categoryNameTR,
    this.descriptionEN,
    this.descriptionTR,
    this.directionsEN,
    this.directionsTR,
    this.imagePath,
    this.videoPath,
    this.ingredients
  });


  @override
  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RecipeToJson(this);

  @override
  Recipe fromJson(Map<String, dynamic> json) {
    return _$RecipeFromJson(json);
  }

@override
List<Object?> get props => [id, nameEN, nameTR, categoryId, categoryNameEN, categoryNameTR, descriptionEN, descriptionTR, directionsEN, directionsTR, imagePath, videoPath, ingredients];
}

@JsonSerializable(explicitToJson: true)
class RecipeListModel extends INetworkModel<RecipeListModel> {
  @JsonKey(name: 'data')
  final List<Recipe>? recipeList;
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
