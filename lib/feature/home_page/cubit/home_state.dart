import 'package:equatable/equatable.dart';
import 'package:recipe_finder/product/model/ingredient/ingredient_model.dart';

import '../../../product/model/recipe_category/category_of_recipes.dart';

abstract class IHomeState {
  IHomeState();
}

class HomeInit extends IHomeState {
  HomeInit();
}

class OnHomeLoading extends IHomeState {
  late bool isLoading;
  OnHomeLoading(isLoading);
}

class HomeError extends IHomeState {
  String errorMessage;
  HomeError(this.errorMessage);
}

class SearchByMealListLoaded extends IHomeState {
  List<IngredientModel>? searchByMealList;
  SearchByMealListLoaded(this.searchByMealList);
}

class CategoryListLoaded extends IHomeState {
  List<IngredientModel>? categoryList;
  CategoryListLoaded(this.categoryList);
}

class EssentialListLoaded extends IHomeState {
  List<IngredientModel>? essentialsList;
  EssentialListLoaded(this.essentialsList);
}

class VegatableListLoaded extends IHomeState {
  List<IngredientModel>? vegatablesList;
  VegatableListLoaded(this.vegatablesList);
}

class HomeState extends Equatable {
  final List<CategoryOfRecipesModel>? categoryList;

  const HomeState({
    this.categoryList,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [categoryList];

  HomeState copyWith({
    List<CategoryOfRecipesModel>? categoryList,
  }) {
    return HomeState(
      categoryList: categoryList ?? this.categoryList,
    );
  }
}
