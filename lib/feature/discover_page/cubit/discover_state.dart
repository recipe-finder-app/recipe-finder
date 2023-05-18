import 'package:equatable/equatable.dart';
import 'package:recipe_finder/product/model/recipe/recipe_model.dart';

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
  late List<RecipeModel> discoverRecipeItemList;
  DiscoverRecipeItemListLoad(this.discoverRecipeItemList);
}

class DiscoverError extends IDiscoverState {
  String errorMessage;
  DiscoverError(this.errorMessage);
}

class DiscoverState extends Equatable {
  final List<RecipeModel>? allRecipeList;
  final List<CategoryOfRecipesModel>? categoryList;
  final CategoryOfRecipesModel? selectedCategory;
  final Map<String, int>? categoryCurrentPageMap;
  const DiscoverState({
    this.allRecipeList,
    this.categoryList,
    this.selectedCategory,
    this.categoryCurrentPageMap,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [allRecipeList, categoryList, selectedCategory, categoryCurrentPageMap];

  DiscoverState copyWith({
    List<RecipeModel>? allRecipeList,
    List<CategoryOfRecipesModel>? categoryList,
    CategoryOfRecipesModel? selectedCategory,
    Map<String, int>? categoryCurrentPageMap,
  }) {
    return DiscoverState(
      allRecipeList: allRecipeList ?? this.allRecipeList,
      categoryList: categoryList ?? this.categoryList,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      categoryCurrentPageMap: categoryCurrentPageMap ?? this.categoryCurrentPageMap,
    );
  }
}
