import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/core/init/cache/hive_manager.dart';
import 'package:recipe_finder/feature/discover_page/service/discover_service.dart';
import 'package:recipe_finder/product/model/error_model.dart';
import 'package:recipe_finder/product/model/ingredient_category/ingredient_category.dart';
import 'package:recipe_finder/product/model/recipe_category/recipe_category.dart';
import 'package:recipe_finder/product/model/user/user_model.dart';
import 'package:recipe_finder/product/service/common_service.dart';
import 'package:recipe_finder/product/utils/enum/hive_enum.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../../product/utils/constant/image_path_enum.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../core/widget/alert_dialog/alert_dialog_error.dart';
import '../../../product/model/ingredient_quantity/ingredient_quantity.dart';
import '../../../product/model/recipe/recipe.dart';
import 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> implements IBaseViewModel {
  DiscoverCubit() : super(const DiscoverState(isLoading: false,recipeCategoryList: [],recipeList: []));
final int pageLimit = 10;
  

 

  late ICommonService commonService;


  void deleteItemFromDiscoverRecipeList(Recipe model) {
   // discoverRecipeList.remove(model);
    // emit(state.copyWith(discoverRecipeItemList: discoverRecipeList));
  }

  @override
  BuildContext? context;

  @override
  void dispose() {
    clearState();
   
  }

  @override
  Future<void> init() async {
    commonService = CommonService();
     changeIsLoadingState();
    await fetchRecipeCategoryList().then((value){
      if(state.selectedCategory!=null && state.selectedCategory!.id!=null){
      fetchRecipeListByCategoryId(state.selectedCategory!.id!);
      }
    });
    changeIsLoadingState();
  }

 

  void changeSelectedCategory(RecipeCategory selectedCategory) {
    emit(state.copyWith(selectedCategory: selectedCategory));
  }

Future<List<Recipe>> fetchRecipeListByCategoryId(String categoryId) async {
  try{
    changeIsLoadingState();
  final allRecipeList = await fetchAllRecipeList();
  final List<Recipe> filteredRecipeList = [];

  for(var recipe in allRecipeList){
    for(var recipeCategory in (recipe.categories ?? [])){
      if(recipeCategory.id==categoryId){
        filteredRecipeList.add(recipe);
      }
    }
  }
  emit(state.copyWith(recipeList: filteredRecipeList));
  return filteredRecipeList;
}
catch (e) {
    
    emit(state.copyWith(error: BaseError(message: e.toString())));
     return [];
   
  } finally {
changeIsLoadingState();
  }
}
Future<void> addToLikedRecipeList(Recipe model) async {
  IHiveManager<UserModel> hiveManager = HiveManager<UserModel>(HiveBoxEnum.userModel);
 final user = await hiveManager.get(HiveKeyEnum.user);
 if(user?.id!=null){
 await commonService.addItemToLikedRecipes(user!.id!, model);
 }
}
Future<void> removeItemFromLikedRecipeList(String recipeId) async {
  IHiveManager<UserModel> hiveManager = HiveManager<UserModel>(HiveBoxEnum.userModel);
 final user = await hiveManager.get(HiveKeyEnum.user);
 if(user?.id!=null){
 await commonService.removeItemFromLikedRecipes(user!.id!, recipeId);
 }
}
Future<List<Recipe>> fetchAllRecipeList() async {
  try {
    List<Recipe> allRecipeList = [];
    final recipeResponse = await commonService.fetchRecipeListWithLimit(limit:pageLimit);
    


    for (var recipe in recipeResponse) {
      var recipeData = recipe.data();
      if (recipeData != null && recipeData.id!=null && recipeData.id!.isNotEmpty) {
       final recipeSubCategoriesResponse = await commonService.fetchRecipeSubCategories(recipeId:recipeData.id!);
       final recipeSubIngredientsResponse = await commonService.fetchRecipeSubIngredients(recipeId:recipeData.id!);
       List<RecipeCategory> categoryList = [];
        List<IngredientQuantity> ingredientList = [];
        for(var ingredient in recipeSubIngredientsResponse){
        var ingredientData = ingredient.data();
        if(ingredientData!=null){
          ingredientList.add(ingredientData);
        }      
       }     
       for(var category in recipeSubCategoriesResponse){
        var categoryData = category.data();
        if(categoryData!=null){
          categoryList.add(categoryData);
        }      
       }
        final copiedData = recipeData.copyWith(categories: categoryList,ingredients: ingredientList);
         allRecipeList.add(copiedData);
      }
    }
    
    return allRecipeList;
  } catch (e) {
    
    emit(state.copyWith(error: BaseError(message: e.toString())));
     return [];
   
  } finally {
  }
}
Future<List<RecipeCategory>> fetchRecipeCategoryList() async {
  try {
    List<RecipeCategory> recipeCategoryList = [];
    final response = await commonService.fetchRecipeCategoryList();


    for (var category in response) {
      var categoryData = category.data();
      if (categoryData != null) {
        recipeCategoryList.add(categoryData);
      }
    }
    emit(state.copyWith(recipeCategoryList: recipeCategoryList)); 
     emit(state.copyWith(selectedCategory: recipeCategoryList[0])); 
    return recipeCategoryList;
  } catch (e) {
    
    emit(state.copyWith(error: BaseError(message: e.toString())));
     return [];
   
  } finally {
  }
}
 @override
  void setContext(BuildContext context) {
    this.context = context;
  }

  void changeIsLoadingState() {
     final isLoading = state.isLoading ?? false;
    emit(state.copyWith(isLoading: !isLoading));
  }
  /*Future<void> fetchRecipeCategoryList() async {
    try {
      changeIsLoadingState();
      final response = await service.fetchCategoryList();
      if (response.data?.success == true) {
        emit(state.copyWith(categoryList: response.data?.recipeCategoryList));
      }
      return;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      showDialog(
          context: context!,
          builder: (context) {
            return AlertDialogError(text: LocaleKeys.anErrorOccured.locale);
          });
    } finally {
      changeIsLoadingState();
    }
  }*/

 /* Future<void> fetchMoreRecipe() async {
    try {
      //scroll oldukça daha fazla tarif getirir.
      emit(state.copyWith(newPageLoading: true));
      print("newpageLoadingState=${state.newPageLoading}");
      final pageKey = state.pageKey + 1;
      emit(state.copyWith(pageKey: pageKey));
      final response = await service.fetchRecipeList(page: pageKey);
      final recipeList = response.data?.recipeList;
      if (recipeList != null) {
        if (recipeList.length < DiscoverService.pageLimit) {
          emit(state.copyWith(hasMoreRecipe: false));
        }
        state.recipeList?.addAll(response.data!.recipeList!); //varolan listenin üzerine yeni gelen elemanları ekler
        emit(state.copyWith(recipeList: state.recipeList));
      }
    } catch (error) {
      throw Exception(error);
    } finally {
      emit(state.copyWith(newPageLoading: false));
      print("newpageLoadingState=${state.newPageLoading}");
    }
  }*/

 /* Future<void> fetchInitialRecipeList() async {
    try {
      changeIsLoadingState();
      final response = await service.fetchInitialRecipeList();
      final recipeList = response.data?.recipeList;
      if (recipeList != null) {
        if (recipeList.length < DiscoverService.pageLimit) {
          emit(state.copyWith(hasMoreRecipe: false));
        }
      }
      emit(state.copyWith(recipeList: recipeList));
    } catch (error) {
      throw Exception(error);
    } finally {
      changeIsLoadingState();
    }
  }*/

  /*Future<void> fetchAllRecipes(
      int page,
      ) async {
    try {
      final newItems = await service!.fetchRecipeList(page: page, limit: limit);
      if (newItems.data?.recipeList != null) {
        final recipeList = newItems.data!.recipeList!;
        final isLastPage = recipeList.length! < limit!;
        if (isLastPage) {
          print("last page girdi");
          pagingController.appendLastPage(recipeList);
        } else {
          print("page girdi");
          final int nextPageKey = page + 1;
          pagingController.appendPage(recipeList, nextPageKey);
        }
      } else {
        pagingController.error = LocaleKeys.anErrorOccured;
      }
    } catch (error) {
      pagingController.error = error;
    }
  }*/
  /*List<Recipe>? recipeListByCategory(dynamic categoryId) {
    if (categoryId != state.selectedCategoryId) {
      emit(state.copyWith(pageKey: 1)); //kategori değişmişse 1.page'den başla
    }
    if (categoryId == allCategoryId) {
      return state.recipeList;
    } else {
      final recipeList = state.recipeList?.where((element) => element.categoryId == categoryId.toString()).toList();

      return recipeList;
    }
  }*/

  void clearState() {
    emit(state.copyWith(isLoading: false, recipeList: [], recipeCategoryList: [], selectedCategory: null, categoryCurrentPageMap: null, pageKey: 1));
  }
}
