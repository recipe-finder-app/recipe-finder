// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_of_ingredient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryOfIngredientModel _$CategoryOfIngredientModelFromJson(
        Map<String, dynamic> json) =>
    CategoryOfIngredientModel(
      id: json['_id'] as String?,
      categoryName: json['name'] as String?,
    );

Map<String, dynamic> _$CategoryOfIngredientModelToJson(
        CategoryOfIngredientModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.categoryName,
    };

CategoryOfIngredientListModel _$CategoryOfIngredientListModelFromJson(
        Map<String, dynamic> json) =>
    CategoryOfIngredientListModel(
      ingredientCategoryList: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              CategoryOfIngredientModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$CategoryOfIngredientListModelToJson(
        CategoryOfIngredientListModel instance) =>
    <String, dynamic>{
      'data': instance.ingredientCategoryList?.map((e) => e.toJson()).toList(),
      'success': instance.success,
    };
