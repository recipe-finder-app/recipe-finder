import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:recipe_finder/product/model/ingredient/ingredient.dart'; 
import 'package:hive_flutter/adapters.dart';

part 'ingredient_quantity.g.dart';



@JsonSerializable()
@HiveType(typeId: 4)
class IngredientQuantity extends Ingredient with EquatableMixin implements HiveObject {
@HiveField(8)
  final double? quantity;
  @HiveField(9)
  @JsonKey(name: "measurement_id")
  final double? measurementId;
  @HiveField(10)
  @JsonKey(name: "measurement_name_en")
  final double? measurementNameEN;
  @HiveField(11)
  @JsonKey(name: "measurement_name_tr")
  final double? measurementNameTR;

      IngredientQuantity({
       String? id,
       String? nameEN,
       String? nameTR,
       String? categoryId,
       String? categoryNameEN,
       String? categoryNameTR,
       String? imageUrl,
       String? color,
    this.quantity,
    this.measurementId,
        this.measurementNameEN,
        this.measurementNameTR,
  }) : super(id: id,nameEN: nameEN,nameTR: nameTR,categoryId:categoryId,categoryNameEN: categoryNameEN,categoryNameTR: categoryNameTR,imageUrl: imageUrl,color: color);




  @override
  factory IngredientQuantity.fromJson(Map<String, dynamic> json) => _$IngredientQuantityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$IngredientQuantityToJson(this);

@override
List<Object?> get props => [id, nameEN, nameTR, categoryId, categoryNameEN, categoryNameTR, imageUrl, color, quantity,measurementId,measurementNameEN,measurementNameTR];

  @override
  IngredientQuantity fromJson(Map<String, dynamic> json) {
    return _$IngredientQuantityFromJson(json);
  }
}
