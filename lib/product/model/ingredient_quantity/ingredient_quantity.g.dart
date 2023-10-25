// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_quantity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IngredientQuantityAdapter extends TypeAdapter<IngredientQuantity> {
  @override
  final int typeId = 4;

  @override
  IngredientQuantity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IngredientQuantity(
      id: fields[0] as String?,
      nameEN: fields[1] as String?,
      nameTR: fields[2] as String?,
      categoryId: fields[3] as String?,
      categoryNameEN: fields[4] as String?,
      categoryNameTR: fields[5] as String?,
      imagePath: fields[6] as String?,
      color: fields[7] as int?,
      quantity: fields[8] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, IngredientQuantity obj) {
    writer
      ..writeByte(9)
      ..writeByte(8)
      ..write(obj.quantity)
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
      other is IngredientQuantityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IngredientQuantity _$IngredientQuantityFromJson(Map<String, dynamic> json) =>
    IngredientQuantity(
      id: json['id'] as String?,
      nameEN: json['name_en'] as String?,
      nameTR: json['name_tr'] as String?,
      categoryId: json['category_id'] as String?,
      categoryNameEN: json['category_name_en'] as String?,
      categoryNameTR: json['category_name_tr'] as String?,
      imagePath: json['imagePath'] as String?,
      color: json['color'] as int?,
      quantity: (json['quantity'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$IngredientQuantityToJson(IngredientQuantity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEN,
      'name_tr': instance.nameTR,
      'category_id': instance.categoryId,
      'category_name_en': instance.categoryNameEN,
      'category_name_tr': instance.categoryNameTR,
      'imagePath': instance.imagePath,
      'color': instance.color,
      'quantity': instance.quantity,
    };
