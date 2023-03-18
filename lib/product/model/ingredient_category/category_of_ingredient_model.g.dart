// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_of_ingredient_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryOfIngredientModelAdapter
    extends TypeAdapter<CategoryOfIngredientModel> {
  @override
  final int typeId = 4;

  @override
  CategoryOfIngredientModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryOfIngredientModel(
      id: fields[0] as String?,
      categoryName: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryOfIngredientModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.categoryName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryOfIngredientModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
