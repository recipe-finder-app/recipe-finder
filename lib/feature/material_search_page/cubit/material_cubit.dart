import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/constant/enum/hive_enum.dart';
import 'package:recipe_finder/core/init/cache/hive_manager.dart';
import 'package:recipe_finder/feature/material_search_page/model/material_search_model.dart';
import 'package:recipe_finder/product/model/ingredient/ingredient_model.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../../product/model/ingredient_category/category_of_ingredient_model.dart';
import '../service/material_service.dart';
import 'material_state.dart';

class MaterialSearchCubit extends Cubit<IMaterialSearchState> implements IBaseViewModel {
  MaterialSearchCubit() : super(MaterialSearchInit());

  IMaterialSearchService? service;

  List<IngredientModel> essentials = [];
  List<IngredientModel> vegetables = [];
  List<IngredientModel> fruits = [];

  late TextEditingController searchTextController;
  late Map<CategoryOfIngredientModel, List<IngredientModel>>? searchedMap;
  late MaterialSearchModel materialSearchModel;
  bool isLoading = false;
  @override
  Future<void> init() async {
    service = MaterialSearchService();
    searchTextController = TextEditingController();
    materialSearchModel = MaterialSearchModel(materialSearchMap: {});
    searchedMap = {};
    await fillMaterialSearchModel();
    ingredientListLoad();
  }

  void changeIsLoadingState() {
    emit(OnMaterialSearchLoading(isLoading: !isLoading));
  }

  Future<void> fillMaterialSearchModel() async {
    try {
      changeIsLoadingState();
      final IHiveManager<MaterialSearchModel> hiveManager = HiveManager<MaterialSearchModel>(HiveBoxEnum.materialSearchMap);
      /*await hiveManager.clear();
      await hiveManager.delete(HiveKeyEnum.materialSearchMap);
      await hiveManager.close();*/
      final getData = await (hiveManager.get(HiveKeyEnum.materialSearchMap));
      if (getData != null) {
        print("cache çalıştı");
        materialSearchModel = getData;
        print("lengh: ${materialSearchModel!.materialSearchMap!.length}");
      } else {
        print("servis çalıştı");
        var ingredientCategoriesList = await categoryOfIngredients();
        ingredientCategoriesList ??= [];
        for (CategoryOfIngredientModel categoryOfIngredient in ingredientCategoriesList) {
          print(categoryOfIngredient.categoryName);
          final ingredientsOfCategoryList = await fetchIngredientsOfCategory(categoryOfIngredient.id!);
          materialSearchModel!.materialSearchMap![categoryOfIngredient] = ingredientsOfCategoryList!;
        }
        await saveMaterialSearchMap(materialSearchModel!);
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      changeIsLoadingState();
    }
  }

  Future<void> saveMaterialSearchMap(
    MaterialSearchModel materialSearchModel,
  ) async {
    final IHiveManager<MaterialSearchModel> hiveManager = HiveManager<MaterialSearchModel>(HiveBoxEnum.materialSearchMap);
    await hiveManager.openBox();
    await hiveManager.put(
      HiveKeyEnum.materialSearchMap,
      materialSearchModel,
    );
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
    for (var entry in materialSearchModel.materialSearchMap!.entries) {
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
    emit(SearchedIngredientListLoad(searchedMap));
  }

  Future<void> searchDataMultiThread(String data) async {
    await compute(searchData, data);
  }

  void ingredientListLoad() {
    searchedMap?.clear();
    emit(IngredientListLoad(materialSearchModel.materialSearchMap));
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
    materialSearchModel = MaterialSearchModel(materialSearchMap: {});
    searchTextController?.clear();
  }
}
