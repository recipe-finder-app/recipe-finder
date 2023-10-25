import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

import '../ingredient_quantity/ingredient_quantity.dart';

part 'recipe.g.dart';

@JsonSerializable()
@HiveType(typeId: 5)
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
  Recipe copyWith({
    ValueGetter<String?>? id,
    ValueGetter<String?>? nameEN,
    ValueGetter<String?>? nameTR,
    ValueGetter<String?>? categoryId,
    ValueGetter<String?>? categoryNameEN,
    ValueGetter<String?>? categoryNameTR,
    ValueGetter<String?>? descriptionEN,
    ValueGetter<String?>? descriptionTR,
    ValueGetter<String?>? directionsEN,
    ValueGetter<String?>? directionsTR,
    ValueGetter<String?>? imagePath,
    ValueGetter<String?>? videoPath,
    ValueGetter<List<IngredientQuantity>?>? ingredients    
  }) {
    return Recipe(
          id: id != null ? id() : this.id,
      nameEN: nameEN != null ? nameEN() : this.nameEN,
      nameTR: nameTR != null ? nameTR() : this.nameTR,
      categoryId: categoryId != null ? categoryId() : this.categoryId,
      categoryNameEN: categoryNameEN != null ? categoryNameEN() : this.categoryNameEN,
      categoryNameTR: categoryNameTR != null ? categoryNameTR() : this.categoryNameTR,
      descriptionEN: descriptionEN != null ? descriptionEN() : this.descriptionEN,
      descriptionTR: descriptionTR != null ? descriptionTR() : this.descriptionTR,
      directionsEN: directionsEN != null ? directionsEN() : this.directionsEN,
      directionsTR: directionsTR != null ? directionsTR() : this.directionsTR,
      imagePath: imagePath != null ? imagePath() : this.imagePath,
      videoPath: videoPath != null ? videoPath() : this.videoPath,
      ingredients: ingredients != null ? ingredients() : this.ingredients
    );
  }
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
