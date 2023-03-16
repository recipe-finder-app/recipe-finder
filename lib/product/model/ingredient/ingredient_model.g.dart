// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IngredientModel _$IngredientModelFromJson(Map<String, dynamic> json) =>
    IngredientModel(
      id: json['_id'] as String?,
      color: json['color'] as int?,
      imagePath: json['imagePath'] as String?,
      title: json['name'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$IngredientModelToJson(IngredientModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.title,
      'imagePath': instance.imagePath,
      'color': instance.color,
      'quantity': instance.quantity,
    };
