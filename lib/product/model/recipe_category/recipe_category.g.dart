// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeCategoryAdapter extends TypeAdapter<RecipeCategory> {
  @override
  final int typeId = 6;

  @override
  RecipeCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeCategory(
      id: fields[0] as String?,
      nameEN: fields[1] as String?,
      nameTR: fields[2] as String?,
      descriptionEN: fields[3] as String?,
      descriptionTR: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RecipeCategory obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nameEN)
      ..writeByte(2)
      ..write(obj.nameTR)
      ..writeByte(3)
      ..write(obj.descriptionEN)
      ..writeByte(4)
      ..write(obj.descriptionTR);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeCategory _$RecipeCategoryFromJson(Map<String, dynamic> json) =>
    RecipeCategory(
      id: json['id'] as String?,
      nameEN: json['name_en'] as String?,
      nameTR: json['name_tr'] as String?,
      descriptionEN: json['description_en'] as String?,
      descriptionTR: json['description_tr'] as String?,
    );

Map<String, dynamic> _$RecipeCategoryToJson(RecipeCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEN,
      'name_tr': instance.nameTR,
      'description_en': instance.descriptionEN,
      'description_tr': instance.descriptionTR,
    };
