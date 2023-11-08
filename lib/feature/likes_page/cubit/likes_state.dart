import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_finder/product/model/base_response_model.dart';
import 'package:recipe_finder/product/model/error_model.dart';
import 'package:recipe_finder/product/model/recipe/recipe.dart';

class LikesState extends Equatable {
      const LikesState({
    this.isLoading,
    this.error,
    this.likedRecipeList
  });


  final bool? isLoading;
  final BaseError? error;
  final List<Recipe>? likedRecipeList;
  

@override
List<Object?> get props => [isLoading, error, likedRecipeList];
  LikesState copyWith({
    bool? isLoading,
    BaseError? error,
    List<Recipe>? likedRecipeList    
  }) {
    return LikesState(
          isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      likedRecipeList: likedRecipeList ?? this.likedRecipeList
    );
  }
}
abstract class ILikesState {
  ILikesState();
}

class LikesInit extends ILikesState {
  LikesInit();
}

class OnLikesLoading extends ILikesState {
  late bool isLoading;
  OnLikesLoading(this.isLoading);
}

class LikesRecipeItemListLoad extends ILikesState {
  late List<Recipe> likesRecipeItemList;
  LikesRecipeItemListLoad(this.likesRecipeItemList);
}

class LikesError extends ILikesState {
  String errorMessage;
  LikesError(this.errorMessage);
}
