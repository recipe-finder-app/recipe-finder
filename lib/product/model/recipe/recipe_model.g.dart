// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeModelAdapter extends TypeAdapter<RecipeModel> {
  @override
  final int typeId = 7;

  @override
  RecipeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeModel(
      id: fields[0] as String?,
      title: fields[1] as String?,
      description: fields[2] as String?,
      categoryId: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RecipeModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.categoryId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeModel _$RecipeModelFromJson(Map<String, dynamic> json) => RecipeModel(
      id: json['_id'] as String?,
      title: json['name'] as String?,
      description: json['description'] as String?,
      categoryId: json['categoryId'] as String?,
      imagePath: json['imagePath'] as String?,
      directions: json['directions'] as String?,
      videoPath: json['videoPath'] as String?,
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((e) => IngredientModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecipeModelToJson(RecipeModel instance) =>
    <String, dynamic>{
      'imagePath': instance.imagePath,
      'directions': instance.directions,
      'videoPath': instance.videoPath,
      'ingredients': instance.ingredients,
      '_id': instance.id,
      'name': instance.title,
      'description': instance.description,
      'categoryId': instance.categoryId,
    };

RecipeListModel _$RecipeListModelFromJson(Map<String, dynamic> json) =>
    RecipeListModel(
      recipeList: (json['data'] as List<dynamic>?)
          ?.map((e) => RecipeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$RecipeListModelToJson(RecipeListModel instance) =>
    <String, dynamic>{
      'data': instance.recipeList?.map((e) => e.toJson()).toList(),
      'success': instance.success,
    };
