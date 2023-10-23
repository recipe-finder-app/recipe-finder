// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredients_of_category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IngredientsOfCategoryModelAdapter
    extends TypeAdapter<IngredientsOfCategoryModel> {
  @override
  final int typeId = 3;

  @override
  IngredientsOfCategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IngredientsOfCategoryModel(
      ingredientList: (fields[0] as List?)?.cast<IngredientQuantity>(),
    );
  }

  @override
  void write(BinaryWriter writer, IngredientsOfCategoryModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.ingredientList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientsOfCategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IngredientsOfCategoryModel _$IngredientsOfCategoryModelFromJson(
        Map<String, dynamic> json) =>
    IngredientsOfCategoryModel(
      ingredientList: (json['data'] as List<dynamic>?)
          ?.map((e) => IngredientQuantity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IngredientsOfCategoryModelToJson(
        IngredientsOfCategoryModel instance) =>
    <String, dynamic>{
      'data': instance.ingredientList,
    };
