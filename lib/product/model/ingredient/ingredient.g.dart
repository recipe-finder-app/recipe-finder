// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IngredientAdapter extends TypeAdapter<Ingredient> {
  @override
  final int typeId = 2;

  @override
  Ingredient read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ingredient(
      id: fields[0] as String?,
      nameEN: fields[1] as String?,
      nameTR: fields[2] as String?,
      categoryId: fields[3] as String?,
      categoryNameEN: fields[4] as String?,
      categoryNameTR: fields[5] as String?,
      imagePath: fields[6] as String?,
      color: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Ingredient obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nameEN)
      ..writeByte(2)
      ..write(obj.nameTR)
      ..writeByte(3)
      ..write(obj.categoryId)
      ..writeByte(4)
      ..write(obj.categoryNameEN)
      ..writeByte(5)
      ..write(obj.categoryNameTR)
      ..writeByte(6)
      ..write(obj.imagePath)
      ..writeByte(7)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
      id: json['id'] as String?,
      nameEN: json['name_en'] as String?,
      nameTR: json['name_tr'] as String?,
      categoryId: json['category_id'] as String?,
      categoryNameEN: json['category_name_en'] as String?,
      categoryNameTR: json['category_name_tr'] as String?,
      imagePath: json['imagePath'] as String?,
      color: json['color'] as int?,
    );

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEN,
      'name_tr': instance.nameTR,
      'category_id': instance.categoryId,
      'category_name_en': instance.categoryNameEN,
      'category_name_tr': instance.categoryNameTR,
      'imagePath': instance.imagePath,
      'color': instance.color,
    };
