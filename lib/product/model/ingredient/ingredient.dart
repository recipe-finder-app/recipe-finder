import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'ingredient.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class Ingredient extends HiveObject with EquatableMixin implements INetworkModel<Ingredient> {
  @HiveField(0)
  @JsonKey(name: 'id')
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
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @HiveField(7)
  final String? color;

  

      Ingredient({
    this.id,
    this.nameEN,
    this.nameTR,
    this.categoryId,
    this.categoryNameEN,
    this.categoryNameTR,
    this.imageUrl,
    this.color,
  });



  @override
  factory Ingredient.fromJson(Map<String, dynamic> json) => _$IngredientFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$IngredientToJson(this);

@override
List<Object?> get props => [id, nameEN, nameTR, categoryId, categoryNameEN, categoryNameTR, imageUrl, color];

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
    String? imageUrl,
    String? color    
  }) {
    return Ingredient(
          id: id ?? this.id,
      nameEN: nameEN ?? this.nameEN,
      nameTR: nameTR ?? this.nameTR,
      categoryId: categoryId ?? this.categoryId,
      categoryNameEN: categoryNameEN ?? this.categoryNameEN,
      categoryNameTR: categoryNameTR ?? this.categoryNameTR,
      imageUrl: imageUrl ?? this.imageUrl,
      color: color ?? this.color
    );
  }
}
