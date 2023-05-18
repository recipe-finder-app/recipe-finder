import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/feature/discover_page/service/discover_service.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../../core/base/view/base_cubit.dart';
import '../../../core/constant/enum/image_path_enum.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../core/widget/alert_dialog/alert_dialog_error.dart';
import '../../../product/model/ingredient/ingredient_model.dart';
import '../../../product/model/recipe/recipe_model.dart';
import 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> implements IBaseViewModel {
  List<RecipeModel> discoverRecipeList = [
    RecipeModel(
      imagePath: ImagePath.imageSample1.path,
      title: 'Cajun spiced Cauliflower Rice with Chicken uzun text deneme uzun text deneme'
          'uzun text deneme',
      ingredients: [
        IngredientModel(title: 'Egg', quantity: 4),
        IngredientModel(title: 'Butter', quantity: 1 / 2),
        IngredientModel(title: 'Butter', quantity: 1 / 2),
        IngredientModel(title: 'Egg', quantity: 4),
        IngredientModel(title: 'Butter', quantity: 1 / 2),
        IngredientModel(title: 'Butter', quantity: 1 / 2),
      ],
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
    ),
    RecipeModel(
      imagePath: ImagePath.imageSample2.path,
      title: 'Cajun spiced Cauliflower Rice with Chicken',
      ingredients: [
        IngredientModel(title: 'Egg', quantity: 4),
        IngredientModel(title: 'Butter', quantity: 1 / 2),
        IngredientModel(title: 'Butter', quantity: 1 / 2),
      ],
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
    ),
    RecipeModel(
      imagePath: ImagePath.imageSample3.path,
      title: 'Cajun spiced Cauliflower Rice with Chicken',
      ingredients: [
        IngredientModel(title: 'Egg', quantity: 4),
        IngredientModel(title: 'Butter', quantity: 1 / 2),
        IngredientModel(title: 'Butter', quantity: 1 / 2),
      ],
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
    ),
    RecipeModel(
      imagePath: ImagePath.imageSample4.path,
      title: 'Cajun spiced Cauliflower Rice with Chicken',
      ingredients: [
        IngredientModel(title: 'Egg', quantity: 4),
        IngredientModel(title: 'Butter', quantity: 1 / 2),
        IngredientModel(title: 'Butter', quantity: 1 / 2),
      ],
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
    ),
    RecipeModel(
      imagePath: ImagePath.imageSample3.path,
      title: 'Cajun spiced Cauliflower Rice with Chicken',
      ingredients: [
        IngredientModel(title: 'Egg', quantity: 4),
        IngredientModel(title: 'Butter', quantity: 1 / 2),
        IngredientModel(title: 'Butter', quantity: 1 / 2),
      ],
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
    ),
    RecipeModel(
      imagePath: ImagePath.imageSample4.path,
      title: 'Cajun spiced Cauliflower Rice with Chicken',
      ingredients: [
        IngredientModel(title: 'Egg', quantity: 4),
        IngredientModel(title: 'Butter', quantity: 1 / 2),
        IngredientModel(title: 'Butter', quantity: 1 / 2),
      ],
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
    ),
  ];
  DiscoverCubit() : super(const DiscoverState());
  int? selectedCategoryIndex;
  late IDiscoverService service;

  void deleteItemFromDiscoverRecipeList(RecipeModel model) {
    discoverRecipeList.remove(model);
    // emit(state.copyWith(discoverRecipeItemList: discoverRecipeList));
  }

  @override
  BuildContext? context;

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<void> init() async {
    service = DiscoverService();
    await fetchCategoryList();
    await fetchAllRecipes(1, 30);
  }

  @override
  void setContext(BuildContext context) {
    this.context = context;
  }

  void changeIsLoadingState() {
    context!.read<BaseCubit>().changeLoadingState();
  }

  void changeSelectedCategory() {}
  Future<void> fetchCategoryList() async {
    try {
      changeIsLoadingState();
      final response = await service!.fetchCategoryList();
      if (response.data?.success == true) {
        emit(state.copyWith(categoryList: response.data?.recipeCategoryList));
        /*response.data?.recipeCategoryList?.forEach((element) {
          print(element.categoryName);
        });*/
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

  Future<void> fetchAllRecipes(int page, int limit) async {
    try {
      changeIsLoadingState();
      final response = await service!.fetchAllRecipeList(page, limit);
      if (response.data?.success == true) {
        emit(state.copyWith(allRecipeList: response.data?.recipeList));
        response.data?.recipeList?.forEach((element) {
          print(element.title);
          print(element.categoryId);
        });
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

  List<RecipeModel>? fetchRecipeOfCategoryList(dynamic categoryId) {
    String allCategoryId = "646626f7c5977497890bd3f8"; // ""tümünü getiren kategorinin id'si.
    if (categoryId == allCategoryId) {
      return state.allRecipeList;
    } else {
      final recipeList = state.allRecipeList?.where((element) => element.categoryId == categoryId.toString()).toList();
      return recipeList;
    }
  }
}
