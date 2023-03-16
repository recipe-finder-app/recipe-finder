import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'ingredient_model.g.dart';

@JsonSerializable()
class IngredientModel extends INetworkModel<IngredientModel> {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'name')
  final String? title;
  final String? imagePath;
  final int? color;

  final double? quantity;

  IngredientModel({
    this.id,
    this.color,
    this.imagePath,
    required this.title,
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
