// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IngredientModelAdapter extends TypeAdapter<IngredientModel> {
  @override
  final int typeId = 2;

  @override
  IngredientModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IngredientModel(
      id: fields[0] as String?,
      color: fields[3] as int?,
      imagePath: fields[2] as String?,
      nameEN: fields[1] as String?,
      quantity: fields[4] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, IngredientModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nameEN)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.color)
      ..writeByte(4)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IngredientModel _$IngredientModelFromJson(Map<String, dynamic> json) =>
    IngredientModel(
      id: json['_id'] as String?,
      color: json['color'] as int?,
      imagePath: json['imagePath'] as String?,
      nameEN: json['name'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$IngredientModelToJson(IngredientModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.nameEN,
      'imagePath': instance.imagePath,
      'color': instance.color,
      'quantity': instance.quantity,
    };
