import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';
import 'package:recipe_finder/product/model/error_model.dart';
import 'package:recipe_finder/product/model/ingredient_category/ingredient_category.dart';

import '../../../product/model/ingredient_category/category_of_ingredient_model.dart';
import '../../../product/model/ingredient_quantity/ingredient_quantity.dart';

abstract class IMaterialSearchState {
  IMaterialSearchState();
}

class MaterialSearchInit extends IMaterialSearchState {
  MaterialSearchInit();
}

class OnMaterialSearchLoading extends IMaterialSearchState {
  final bool? isLoading;
  OnMaterialSearchLoading({this.isLoading});
}

class MaterialSearchError extends IMaterialSearchState {
  String errorMessage;
  MaterialSearchError(this.errorMessage);
}

class IngredientListLoad extends IMaterialSearchState {
  Map<CategoryOfIngredientModel, List<IngredientQuantity>>? materialSearchMap;
  IngredientListLoad(this.materialSearchMap);
}

class SearchedIngredientListLoad extends IMaterialSearchState {
  Map<CategoryOfIngredientModel, List<IngredientQuantity>>? searchedMap;
  SearchedIngredientListLoad(this.searchedMap);
}

class MaterialSearchState extends Equatable{
  final bool? isLoading;
  final BaseError? error;
  final Map<IngredientCategory, List<IngredientQuantity>>? materialSearchMap;
  final Map<IngredientCategory, List<IngredientQuantity>>? materialSearchSearchedMap;
   const  MaterialSearchState({
    this.isLoading,
    this.error,
    this.materialSearchMap,
    this.materialSearchSearchedMap
  });

 

@override
List<Object?> get props => [isLoading, error, materialSearchMap,materialSearchSearchedMap];
  MaterialSearchState copyWith({
    bool? isLoading,
   BaseError? error,
    Map<IngredientCategory, List<IngredientQuantity>>? materialSearchMap,  
    Map<IngredientCategory, List<IngredientQuantity>>? materialSearchSearchedMap,
  }) {
    return MaterialSearchState(
          isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      materialSearchMap: materialSearchMap ?? this.materialSearchMap,
      materialSearchSearchedMap: materialSearchSearchedMap ?? this.materialSearchSearchedMap,
    );
  }
}

