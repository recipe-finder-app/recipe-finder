import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/feature/discover_page/service/discover_service.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../../product/utils/constant/image_path_enum.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../core/widget/alert_dialog/alert_dialog_error.dart';
import '../../../product/model/ingredient/ingredient_model.dart';
import '../../../product/model/recipe/recipe_model.dart';
import 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> implements IBaseViewModel {
  DiscoverCubit() : super(const DiscoverState(isLoading: false));

  late PagingController<int, RecipeModel> pagingController;
  late ScrollController scrollController;
  List<RecipeModel> discoverRecipeList = [
    RecipeModel(
      imagePath: ImagePathConstant.imageSample1.path,
      title: 'Cajun spiced Cauliflower Rice with Chicken uzun text deneme uzun text deneme'
          'uzun text deneme',
      ingredients: [
        IngredientModel(nameEN: 'Egg', quantity: 4),
        IngredientModel(nameEN: 'Butter', quantity: 1 / 2),
        IngredientModel(nameEN: 'Butter', quantity: 1 / 2),
        IngredientModel(nameEN: 'Egg', quantity: 4),
        IngredientModel(nameEN: 'Butter', quantity: 1 / 2),
        IngredientModel(nameEN: 'Butter', quantity: 1 / 2),
      ],
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
    ),
    RecipeModel(
      imagePath: ImagePathConstant.imageSample2.path,
      title: 'Cajun spiced Cauliflower Rice with Chicken',
      ingredients: [
        IngredientModel(nameEN: 'Egg', quantity: 4),
        IngredientModel(nameEN: 'Butter', quantity: 1 / 2),
        IngredientModel(nameEN: 'Butter', quantity: 1 / 2),
      ],
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
    ),
    RecipeModel(
      imagePath: ImagePathConstant.imageSample3.path,
      title: 'Cajun spiced Cauliflower Rice with Chicken',
      ingredients: [
        IngredientModel(nameEN: 'Egg', quantity: 4),
        IngredientModel(nameEN: 'Butter', quantity: 1 / 2),
        IngredientModel(nameEN: 'Butter', quantity: 1 / 2),
      ],
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
    ),
    RecipeModel(
      imagePath: ImagePathConstant.imageSample4.path,
      title: 'Cajun spiced Cauliflower Rice with Chicken',
      ingredients: [
        IngredientModel(nameEN: 'Egg', quantity: 4),
        IngredientModel(nameEN: 'Butter', quantity: 1 / 2),
        IngredientModel(nameEN: 'Butter', quantity: 1 / 2),
      ],
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
    ),
    RecipeModel(
      imagePath: ImagePathConstant.imageSample3.path,
      title: 'Cajun spiced Cauliflower Rice with Chicken',
      ingredients: [
        IngredientModel(nameEN: 'Egg', quantity: 4),
        IngredientModel(nameEN: 'Butter', quantity: 1 / 2),
        IngredientModel(nameEN: 'Butter', quantity: 1 / 2),
      ],
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
    ),
    RecipeModel(
      imagePath: ImagePathConstant.imageSample4.path,
      title: 'Cajun spiced Cauliflower Rice with Chicken',
      ingredients: [
        IngredientModel(nameEN: 'Egg', quantity: 4),
        IngredientModel(nameEN: 'Butter', quantity: 1 / 2),
        IngredientModel(nameEN: 'Butter', quantity: 1 / 2),
      ],
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
    ),
  ];

  late IDiscoverService service;
  final String allCategoryId = "646626f7c5977497890bd3f8"; // ""tümünü getiren kategorinin id'si.

  void deleteItemFromDiscoverRecipeList(RecipeModel model) {
    discoverRecipeList.remove(model);
    // emit(state.copyWith(discoverRecipeItemList: discoverRecipeList));
  }

  @override
  BuildContext? context;

  @override
  void dispose() {
    clearState();
    pagingController.dispose();
    scrollController.dispose();
  }

  @override
  Future<void> init() async {
    service = DiscoverService();
    scrollController = ScrollController();
    //pagingController = PagingController(firstPageKey: 1);
    changeSelectedCategory(allCategoryId);
    await fetchCategoryList();
    await fetchInitialRecipeList();
    scrollController.addListener(() async {
      if (scrollController.offset == scrollController.position.maxScrollExtent && state.newPageLoading == false) {
        await fetchMoreRecipe();
      }
    });
    /*pagingController.addPageRequestListener((pageKey) {
      fetchAllRecipes(pageKey);
    });*/
  }

  @override
  void setContext(BuildContext context) {
    this.context = context;
  }

  void changeIsLoadingState() {
    print("loading state ${state.isLoading}");
    emit(state.copyWith(isLoading: !state.isLoading!));
    print("loading state ${state.isLoading}");
  }

  void changeSelectedCategory(categoryId) {
    emit(state.copyWith(selectedCategoryId: categoryId));
  }

  Future<void> fetchCategoryList() async {
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
  }

  Future<void> fetchMoreRecipe() async {
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
  }

  Future<void> fetchInitialRecipeList() async {
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
  }

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
  List<RecipeModel>? recipeListByCategory(dynamic categoryId) {
    if (categoryId != state.selectedCategoryId) {
      emit(state.copyWith(pageKey: 1)); //kategori değişmişse 1.page'den başla
    }
    if (categoryId == allCategoryId) {
      return state.recipeList;
    } else {
      final recipeList = state.recipeList?.where((element) => element.categoryId == categoryId.toString()).toList();

      return recipeList;
    }
  }

  void clearState() {
    emit(state.copyWith(isLoading: false, recipeList: [], categoryList: [], selectedCategoryId: null, categoryCurrentPageMap: null, pageKey: 1));
  }
}
