import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'ingredient_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class IngredientModel extends HiveObject implements INetworkModel<IngredientModel> {
  @JsonKey(name: '_id')
  @HiveField(0)
  final String? id;

  @JsonKey(name: 'name')
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? imagePath;
  @HiveField(3)
  final int? color;
  @HiveField(4)
  final double? quantity;

  IngredientModel({
    this.id,
    this.color,
    this.imagePath,
    this.title,
    this.quantity,
  });

  @override
  factory IngredientModel.fromJson(Map<String, dynamic> json) => _$IngredientModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$IngredientModelToJson(this);

  @override
  IngredientModel fromJson(Map<String, dynamic> json) {
    return _$IngredientModelFromJson(json);
  }
}
