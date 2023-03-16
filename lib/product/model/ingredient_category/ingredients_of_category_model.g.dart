// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredients_of_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IngredientsOfCategoryModel _$IngredientsOfCategoryModelFromJson(
        Map<String, dynamic> json) =>
    IngredientsOfCategoryModel(
      ingredientList: (json['data'] as List<dynamic>?)
          ?.map((e) => IngredientModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IngredientsOfCategoryModelToJson(
        IngredientsOfCategoryModel instance) =>
    <String, dynamic>{
      'data': instance.ingredientList,
    };
