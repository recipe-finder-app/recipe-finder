import 'package:equatable/equatable.dart';
import 'package:recipe_finder/product/model/recipe/recipe.dart';

import '../../../product/model/recipe_category/category_of_recipes.dart';

abstract class IDiscoverState {
  IDiscoverState();
}

class DiscoverInit extends IDiscoverState {
  DiscoverInit();
}

class DiscoverLoading extends IDiscoverState {
  late bool isLoading;
  DiscoverLoading(isLoading);
}

class ChangeSelectedCategoryIndex extends IDiscoverState {
  int? index;
  ChangeSelectedCategoryIndex(this.index);
}

class DiscoverRecipeItemListLoad extends IDiscoverState {
  late List<Recipe> discoverRecipeItemList;
  DiscoverRecipeItemListLoad(this.discoverRecipeItemList);
}

class DiscoverError extends IDiscoverState {
  String errorMessage;
  DiscoverError(this.errorMessage);
}

class DiscoverState extends Equatable {
  final List<Recipe>? recipeList;
  final List<CategoryOfRecipesModel>? categoryList;
  final dynamic selectedCategoryId;
  final Map<String, int>? categoryCurrentPageMap;
  final bool? isLoading;
  final int pageKey;
  final bool hasMoreRecipe;
  final bool newPageLoading;
  const DiscoverState({
    this.recipeList,
    this.categoryList,
    this.selectedCategoryId,
    this.categoryCurrentPageMap,
    this.isLoading = false,
    this.pageKey = 1,
    this.hasMoreRecipe = true,
    this.newPageLoading = false,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [recipeList, categoryList, selectedCategoryId, categoryCurrentPageMap, isLoading, pageKey, hasMoreRecipe, newPageLoading];

  DiscoverState copyWith({
    List<Recipe>? recipeList,
    List<CategoryOfRecipesModel>? categoryList,
    dynamic? selectedCategoryId,
    Map<String, int>? categoryCurrentPageMap,
    bool? isLoading,
    int? pageKey,
    bool? hasMoreRecipe,
    bool? newPageLoading,
  }) {
    return DiscoverState(
      recipeList: recipeList ?? this.recipeList,
      categoryList: categoryList ?? this.categoryList,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      categoryCurrentPageMap: categoryCurrentPageMap ?? this.categoryCurrentPageMap,
      isLoading: isLoading ?? this.isLoading,
      pageKey: pageKey ?? this.pageKey,
      hasMoreRecipe: hasMoreRecipe ?? this.hasMoreRecipe,
      newPageLoading: newPageLoading ?? this.newPageLoading,
    );
  }
}
