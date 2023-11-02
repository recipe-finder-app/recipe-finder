// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeAdapter extends TypeAdapter<Recipe> {
  @override
  final int typeId = 5;

  @override
  Recipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recipe(
      id: fields[0] as String?,
      nameEN: fields[1] as String?,
      nameTR: fields[2] as String?,
      descriptionEN: fields[6] as String?,
      descriptionTR: fields[7] as String?,
      directionsEN: fields[8] as String?,
      directionsTR: fields[9] as String?,
      imagePath: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nameEN)
      ..writeByte(2)
      ..write(obj.nameTR)
      ..writeByte(6)
      ..write(obj.descriptionEN)
      ..writeByte(7)
      ..write(obj.descriptionTR)
      ..writeByte(8)
      ..write(obj.directionsEN)
      ..writeByte(9)
      ..write(obj.directionsTR)
      ..writeByte(10)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
      id: json['id'] as String?,
      nameEN: json['name_en'] as String?,
      nameTR: json['name_tr'] as String?,
      descriptionEN: json['description_en'] as String?,
      descriptionTR: json['description_tr'] as String?,
      directionsEN: json['directions_en'] as String?,
      directionsTR: json['directions_tr'] as String?,
      imagePath: json['image_url'] as String?,
      videoPath: json['videoPath'] as String?,
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((e) => IngredientQuantity.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => RecipeCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEN,
      'name_tr': instance.nameTR,
      'description_en': instance.descriptionEN,
      'description_tr': instance.descriptionTR,
      'directions_en': instance.directionsEN,
      'directions_tr': instance.directionsTR,
      'image_url': instance.imagePath,
      'videoPath': instance.videoPath,
      'ingredients': instance.ingredients,
      'categories': instance.categories,
    };

RecipeListModel _$RecipeListModelFromJson(Map<String, dynamic> json) =>
    RecipeListModel(
      recipeList: (json['data'] as List<dynamic>?)
          ?.map((e) => Recipe.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$RecipeListModelToJson(RecipeListModel instance) =>
    <String, dynamic>{
      'data': instance.recipeList?.map((e) => e.toJson()).toList(),
      'success': instance.success,
    };
