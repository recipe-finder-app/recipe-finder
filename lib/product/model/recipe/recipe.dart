
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:recipe_finder/product/model/recipe_category/recipe_category.dart';
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

  @JsonKey(name: 'description_en')
  @HiveField(3)
  final String? descriptionEN;

  @JsonKey(name: 'description_tr')
  @HiveField(4)
  final String? descriptionTR;

  @JsonKey(name: 'directions_en')
  @HiveField(5)
   final String? directionsEN;

@JsonKey(name: 'directions_tr')
  @HiveField(6)
   final String? directionsTR;

@JsonKey(name: 'image_url')
  @HiveField(7)
   final String? imagePath;

 
  final String? videoPath;
  
   @JsonKey(includeToJson: false)
  final List<IngredientQuantity>? ingredients;

  @JsonKey(includeToJson: false)
   final List<RecipeCategory>? categories;

 
      Recipe({
    this.id,
    this.nameEN,
    this.nameTR,
    this.descriptionEN,
    this.descriptionTR,
    this.directionsEN,
    this.directionsTR,
    this.imagePath,
    this.videoPath,
    this.ingredients,
    this.categories,
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
List<Object?> get props => [id, nameEN, nameTR, descriptionEN, descriptionTR, directionsEN, directionsTR, imagePath, videoPath, ingredients,categories];
  Recipe copyWith({
   String? id,
   String? nameEN,
   String? nameTR,
   String? descriptionEN,
   String? descriptionTR,
   String? directionsEN,
   String? directionsTR,
   String? imagePath,
   String? videoPath,
    List<IngredientQuantity>? ingredients,
    List<RecipeCategory>? categories,

  }) {
    return Recipe(
          id: id ?? this.id,
      nameEN: nameEN ?? this.nameEN,
      nameTR: nameTR ?? this.nameTR,
      descriptionEN: descriptionEN ?? this.descriptionEN,
      descriptionTR: descriptionTR ?? this.descriptionTR,
      directionsEN: directionsEN ?? this.directionsEN,
      directionsTR: directionsTR ?? this.directionsTR,
      imagePath: imagePath ?? this.imagePath,
      videoPath: videoPath ?? this.videoPath,
      ingredients: ingredients ?? this.ingredients,
      categories: categories ?? this.categories
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
