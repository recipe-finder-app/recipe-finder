import 'package:equatable/equatable.dart';
import 'package:recipe_finder/product/model/base_response_model.dart';
import 'package:recipe_finder/product/model/error_model.dart';
import 'package:recipe_finder/product/model/recipe/recipe.dart';
import 'package:recipe_finder/product/model/recipe_category/recipe_category.dart';
import '../../../product/model/recipe_category/category_of_recipes.dart';

class DiscoverState extends Equatable {
  final List<Recipe>? recipeList;
  final List<RecipeCategory>? recipeCategoryList;
  final RecipeCategory? selectedCategory;
  final Map<String, int>? categoryCurrentPageMap;
  final bool? isLoading;
  final int pageKey;
  final bool hasMoreRecipe;
  final bool newPageLoading;
  final BaseError? error;
  const DiscoverState({
    this.recipeList,
    this.recipeCategoryList,
    this.selectedCategory,
    this.categoryCurrentPageMap,
    this.isLoading,
    this.pageKey = 1,
    this.hasMoreRecipe = true,
    this.newPageLoading = false,
    this.error,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [recipeList, recipeCategoryList, selectedCategory, categoryCurrentPageMap, isLoading, pageKey, hasMoreRecipe, newPageLoading,error];

  DiscoverState copyWith({
    List<Recipe>? recipeList,
    List<RecipeCategory>? recipeCategoryList,
    RecipeCategory? selectedCategory,
    Map<String, int>? categoryCurrentPageMap,
    bool? isLoading,
    int? pageKey,
    bool? hasMoreRecipe,
    bool? newPageLoading,
    BaseError? error,
  }) {
    return DiscoverState(
      recipeList: recipeList ?? this.recipeList,
      recipeCategoryList: recipeCategoryList ?? this.recipeCategoryList,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      categoryCurrentPageMap: categoryCurrentPageMap ?? this.categoryCurrentPageMap,
      isLoading: isLoading ?? this.isLoading,
      pageKey: pageKey ?? this.pageKey,
      hasMoreRecipe: hasMoreRecipe ?? this.hasMoreRecipe,
      newPageLoading: newPageLoading ?? this.newPageLoading,
       error: error ?? this.error,
    );
  }
}
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


