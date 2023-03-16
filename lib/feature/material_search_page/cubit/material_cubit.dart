import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/product/model/ingredient/ingredient_model.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../../core/base/view/base_cubit.dart';
import '../../../product/model/ingredient_category/category_of_ingredient_model.dart';
import '../service/material_service.dart';
import 'material_state.dart';

class MaterialSearchCubit extends Cubit<IMaterialSearchState> implements IBaseViewModel {
  IMaterialSearchService? service;

  MaterialSearchCubit() : super(MaterialSearchInit());

  List<IngredientModel> essentials = [];
  List<IngredientModel> vegetables = [];
  List<IngredientModel> fruits = [];

  late Map<CategoryOfIngredientModel, List<IngredientModel>>? materialSearchInitMap;
  late Map<CategoryOfIngredientModel, List<IngredientModel>>? searchedMap;
  late TextEditingController searchTextController;

  @override
  Future<void> init() async {
    service = MaterialSearchService();
    searchTextController = TextEditingController();
    materialSearchInitMap = {};
    await fillMaterialSearchInitMap();
    searchedMap = {};
    ingredientListLoad();
    categoryOfIngredients();
  }

  void changeIsLoadingState() {
    context?.read<BaseCubit>().changeLoadingState();
  }

  Future<void> fillMaterialSearchInitMap() async {
    changeIsLoadingState();
    var ingredientCategoriesList = await categoryOfIngredients();
    ingredientCategoriesList ??= [];
    for (CategoryOfIngredientModel categoryOfIngredient in ingredientCategoriesList) {
      print(categoryOfIngredient.categoryName);
      final ingredientsOfCategoryList = await fetchIngredientsOfCategory(categoryOfIngredient.id!);
      ingredientCategoriesList ??= [];
      materialSearchInitMap![categoryOfIngredient] = ingredientsOfCategoryList!;
      print(categoryOfIngredient.categoryName);
      print("----------------------");
      for (var i in (ingredientsOfCategoryList)) {
        print(i.title);
      }
    }
    changeIsLoadingState();
  }

  Future<List<CategoryOfIngredientModel>?> categoryOfIngredients() async {
    final result = await service!.categoryOfIngredient();
    return result?.data?.ingredientCategoryList?.toList();
  }

  Future<List<IngredientModel>?> fetchIngredientsOfCategory(String categoryId) async {
    final result = await service!.ingredientsOfCategory(categoryId);
    return result?.data?.ingredientList?.toList();
  }

  void searchData(String data) {
    searchedMap?.clear();
    data = data.toLowerCase();
    for (var entry in materialSearchInitMap!.entries) {
      if (entry.key.categoryName!.toLowerCase().contains(data)) {
        searchedMap?[entry.key] = entry.value;
      } else {
        for (var element in entry.value) {
          if (element.title!.toLowerCase().contains(data)) {
            searchedMap?[entry.key] = entry.value.where((element) => element.title!.toLowerCase().contains(data)).toList();
          }
        }
      }
    }
    /*for (
    var entry in materialSearchModel.materialSearchMap.entries) {
      for (var element in entry.value) {
        if (element.title.toLowerCase().contains(data)) {
          searchedMap?[entry.key] = entry.value.where((element) => element.title.toLowerCase().contains(data)).toList();
        }
      }
    }*/
    emit(SearchedIngredientListLoad(searchedMap));
  }

  Future<void> searchDataMultiThread(String data) async {
    await compute(searchData, data);
  }

  void ingredientListLoad() {
    searchedMap?.clear();
    emit(IngredientListLoad(materialSearchInitMap));
  }

  @override
  BuildContext? context;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void dispose() {
    clear();
  }

  void clear() {
    essentials = [];
    vegetables = [];
    fruits = [];
    searchedMap?.clear();
    materialSearchInitMap?.clear();
    searchTextController?.clear();
  }
}
