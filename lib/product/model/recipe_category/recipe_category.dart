
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
part 'recipe_category.g.dart';

@JsonSerializable()
@HiveType(typeId: 6)
class RecipeCategory extends HiveObject with EquatableMixin implements INetworkModel<RecipeCategory> {
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

    RecipeCategory({
    this.id,
    this.nameEN,
    this.nameTR,
    this.descriptionEN,
    this.descriptionTR
  });


  @override
  factory RecipeCategory.fromJson(Map<String, dynamic> json) => _$RecipeCategoryFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RecipeCategoryToJson(this);

  @override
  RecipeCategory fromJson(Map<String, dynamic> json) {
    return _$RecipeCategoryFromJson(json);
  }

@override
List<Object?> get props => [id, nameEN, nameTR, descriptionEN, descriptionTR];
  RecipeCategory copyWith({
    String? id,
    String? nameEN,
    String? nameTR,
    String? descriptionEN,
    String? descriptionTR    
  }) {
    return RecipeCategory(
          id: id ?? this.id,
      nameEN: nameEN ?? this.nameEN,
      nameTR: nameTR ?? this.nameTR,
      descriptionEN: descriptionEN ?? this.descriptionEN,
      descriptionTR: descriptionTR ?? this.descriptionTR
    );
  }
}

