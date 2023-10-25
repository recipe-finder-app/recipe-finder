import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:vexana/vexana.dart';


part 'ingredient_category.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class IngredientCategory extends HiveObject with EquatableMixin implements INetworkModel<IngredientCategory> {
   @JsonKey(name: 'id')
  @HiveField(0)
  final String? id;

  @JsonKey(name: 'name_en')
  @HiveField(1)
  final String? nameEN;

  @JsonKey(name: 'name_tr')
  @HiveField(2)
  final String? nameTR;
  
   @JsonKey(name: 'description_en')
  @HiveField(3)
  final String? descriptionEN;

  @JsonKey(name: 'description_tr')
  @HiveField(4)
  final String? descriptionTR;
          IngredientCategory({
    this.id,
    this.nameEN,
    this.nameTR,
    this.descriptionEN,
    this.descriptionTR
  });





  @override
  factory IngredientCategory.fromJson(Map<String, dynamic> json) => _$IngredientCategoryFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$IngredientCategoryToJson(this);

  @override
  IngredientCategory fromJson(Map<String, dynamic> json) {
    return _$IngredientCategoryFromJson(json);
  }

@override
List<Object?> get props => [id, nameEN, nameTR, descriptionEN, descriptionTR];
  

  IngredientCategory copyWith({
   String? id,
    String? nameEN,
   String? nameTR,
    String? descriptionEN,
    String? descriptionTR    
  }) {
    return IngredientCategory(
          id: id ?? this.id,
      nameEN: nameEN ?? this.nameEN,
      nameTR: id ?? this.nameTR,
      descriptionEN: id ?? this.descriptionEN,
      descriptionTR: id ?? this.descriptionTR,
    );
  }
}

