// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_of_recipes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryOfRecipesModelAdapter
    extends TypeAdapter<CategoryOfRecipesModel> {
  @override
  final int typeId = 6;

  @override
  CategoryOfRecipesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryOfRecipesModel(
      id: fields[0] as String?,
      categoryName: fields[1] as String?,
      color: fields[2] as String?,
      imagePath: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryOfRecipesModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.categoryName)
      ..writeByte(2)
      ..write(obj.color)
      ..writeByte(3)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryOfRecipesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryOfRecipesModel _$CategoryOfRecipesModelFromJson(
        Map<String, dynamic> json) =>
    CategoryOfRecipesModel(
      id: json['_id'] as String?,
      categoryName: json['name'] as String?,
      color: json['color'] as String?,
      imagePath: json['imagePath'] as String?,
    );

Map<String, dynamic> _$CategoryOfRecipesModelToJson(
        CategoryOfRecipesModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.categoryName,
      'color': instance.color,
      'imagePath': instance.imagePath,
    };

CategoryOfRecipesListModel _$CategoryOfRecipesListModelFromJson(
        Map<String, dynamic> json) =>
    CategoryOfRecipesListModel(
      recipeCategoryList: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => CategoryOfRecipesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$CategoryOfRecipesListModelToJson(
        CategoryOfRecipesListModel instance) =>
    <String, dynamic>{
      'data': instance.recipeCategoryList?.map((e) => e.toJson()).toList(),
      'success': instance.success,
    };
