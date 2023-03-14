// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IngredientCategoryModel _$IngredientCategoryModelFromJson(
        Map<String, dynamic> json) =>
    IngredientCategoryModel(
      id: json['_id'] as String?,
      categoryName: json['name'] as String?,
    );

Map<String, dynamic> _$IngredientCategoryModelToJson(
        IngredientCategoryModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.categoryName,
    };

IngredientCategoryListModel _$IngredientCategoryListModelFromJson(
        Map<String, dynamic> json) =>
    IngredientCategoryListModel(
      ingredientCategoryList: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              IngredientCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$IngredientCategoryListModelToJson(
        IngredientCategoryListModel instance) =>
    <String, dynamic>{
      'data': instance.ingredientCategoryList?.map((e) => e.toJson()).toList(),
      'success': instance.success,
    };
