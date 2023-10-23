import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:recipe_finder/product/model/ingredient/ingredient.dart'; 
import 'package:hive_flutter/adapters.dart';

part 'ingredient_quantity.g.dart';



@JsonSerializable()
@HiveType(typeId: 3)
class IngredientQuantity extends Ingredient with EquatableMixin implements HiveObject {
@HiveField(8)
  final double? quantity;

      IngredientQuantity({
       String? id,
       String? nameEN,
       String? nameTR,
       String? categoryId,
       String? categoryNameEN,
       String? categoryNameTR,
       String? imagePath,
       int? color,

    this.quantity
  }) : super(id: id,nameEN: nameEN,nameTR: nameTR,categoryId:categoryId,categoryNameEN: categoryNameEN,categoryNameTR: categoryNameTR,imagePath: imagePath,color: color);




  @override
  factory IngredientQuantity.fromJson(Map<String, dynamic> json) => _$IngredientQuantityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$IngredientQuantityToJson(this);

@override
List<Object?> get props => [id, nameEN, nameTR, categoryId, categoryNameEN, categoryNameTR, imagePath, color, quantity];

  @override
  IngredientQuantity fromJson(Map<String, dynamic> json) {
    return _$IngredientQuantityFromJson(json);
  }
}
