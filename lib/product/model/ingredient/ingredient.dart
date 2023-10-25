import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'ingredient.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class Ingredient extends HiveObject  with EquatableMixin implements INetworkModel<Ingredient> {
  @HiveField(0)
  final String? id;

  @JsonKey(name: 'name_en')
  @HiveField(1)
  final String? nameEN;

   @JsonKey(name: 'name_tr')
  @HiveField(2)
  final String? nameTR;

   @JsonKey(name: 'category_id')
  @HiveField(3)
  final String? categoryId;

    @JsonKey(name: 'category_name_en')
  @HiveField(4)
  final String? categoryNameEN;

    @JsonKey(name: 'category_name_tr')
  @HiveField(5)
  final String? categoryNameTR;
  
  @HiveField(6)
  final String? imagePath;

  @HiveField(7)
  final int? color;
  

      Ingredient({
    this.id,
    this.nameEN,
    this.nameTR,
    this.categoryId,
    this.categoryNameEN,
    this.categoryNameTR,
    this.imagePath,
    this.color
  });



  @override
  factory Ingredient.fromJson(Map<String, dynamic> json) => _$IngredientFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$IngredientToJson(this);

@override
List<Object?> get props => [id, nameEN, nameTR, categoryId, categoryNameEN, categoryNameTR, imagePath, color];

  @override
  Ingredient fromJson(Map<String, dynamic> json) {
    return _$IngredientFromJson(json);
  }
  Ingredient copyWith({
    String? id,
    String? nameEN,
    String? nameTR,
    String? categoryId,
    String? categoryNameEN,
    String? categoryNameTR,
    String? imagePath,
    int? color    
  }) {
    return Ingredient(
          id: id ?? this.id,
      nameEN: nameEN ?? this.nameEN,
      nameTR: nameTR ?? this.nameTR,
      categoryId: categoryId ?? this.categoryId,
      categoryNameEN: categoryNameEN ?? this.categoryNameEN,
      categoryNameTR: categoryNameTR ?? this.categoryNameTR,
      imagePath: imagePath ?? this.imagePath,
      color: color ?? this.color
    );
  }
}
