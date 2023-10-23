import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'ingredient_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class IngredientModel extends HiveObject implements INetworkModel<IngredientModel> {
  @HiveField(0)
  final String? id;

  @JsonKey(name: 'name_en')
  @HiveField(1)
  final String? nameEN;

   @JsonKey(name: 'name_tr')
  @HiveField(1)
  final String? nameTR;

   @JsonKey(name: 'category_id')
  @HiveField(1)
  final String? categoryId;

    @JsonKey(name: 'category_name_en')
  @HiveField(1)
  final String? categoryNameEN;

    @JsonKey(name: 'category_name_tr')
  @HiveField(1)
  final String? categoryNameTR;
  
  @HiveField(2)
  final String? imagePath;

  @HiveField(3)
  final int? color;
  
  @HiveField(4)
  final double? quantity;

    IngredientModel({
    this.id,
    this.nameEN,
    this.nameTR,
    this.categoryId,
    this.categoryNameEN,
    this.categoryNameTR,
    this.imagePath,
    this.color,
    this.quantity
  });


  @override
  factory IngredientModel.fromJson(Map<String, dynamic> json) => _$IngredientModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$IngredientModelToJson(this);

@override
List<Object?> get props => [id, nameEN, nameTR, categoryId, categoryNameEN, categoryNameTR, imagePath, color, quantity];

  @override
  IngredientModel fromJson(Map<String, dynamic> json) {
    return _$IngredientModelFromJson(json);
  }
}
