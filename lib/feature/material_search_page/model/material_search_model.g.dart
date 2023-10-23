// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_search_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MaterialSearchModelAdapter extends TypeAdapter<MaterialSearchModel> {
  @override
  final int typeId = 5;

  @override
  MaterialSearchModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MaterialSearchModel(
      materialSearchMap: (fields[0] as Map?)?.map((dynamic k, dynamic v) =>
          MapEntry(k as CategoryOfIngredientModel,
              (v as List).cast<IngredientQuantity>())),
    );
  }

  @override
  void write(BinaryWriter writer, MaterialSearchModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.materialSearchMap);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MaterialSearchModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
