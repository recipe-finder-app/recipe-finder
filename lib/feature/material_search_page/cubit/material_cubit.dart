import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/init/language/language_manager.dart';
import 'package:recipe_finder/product/model/ingredient/ingredient.dart';
import 'package:recipe_finder/product/model/ingredient_category/ingredient_category.dart';
import 'package:recipe_finder/product/model/ingredient_quantity/ingredient_quantity.dart';
import 'package:recipe_finder/product/utils/enum/hive_enum.dart';
import 'package:recipe_finder/core/init/cache/hive_manager.dart';
import 'package:recipe_finder/feature/material_search_page/model/material_search_model.dart';
import '../../../product/model/ingredient_quantity/ingredient_quantity.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../../product/model/ingredient_category/category_of_ingredient_model.dart';
import '../service/material_service.dart';
import 'material_state.dart';

class MaterialSearchCubits extends Cubit<MaterialSearchState> implements IBaseViewModel {
   MaterialSearchCubits() : super(const MaterialSearchState(isLoading: false,materialSearchMap: {},materialSearchSearchedMap: {}));
   late TextEditingController searchTextController;
   late IMaterialSearchService service;
     @override
     BuildContext? context;
   
     @override
     void dispose() {
    // TODO: implement dispose
     }
   
     @override
     Future<void> init() async {
      service = MaterialSearchService();
     searchTextController = TextEditingController();
     await fillMaterialSearchMap();
     } 

     Future<List<QueryDocumentSnapshot<IngredientCategory?>>> fetchIngredientCategoryList() async {
     final response = await service.fetchIngredientCategories().get();
     final responseDocs = response.docs;
     return responseDocs;
     }
     Future<List<QueryDocumentSnapshot<Ingredient?>>> fetchIngredientList() async {
     final response = await service.fetchIngredientList().get();
     final responseDocs = response.docs;
     return responseDocs;
     }
     void searchData(String data) {
     emit(state.copyWith(materialSearchMap: {}));
     data = data.toLowerCase();
     var searchedMap = state.materialSearchSearchedMap;
     if(context!=null){
     Locale currentLocale = LanguageManager.instance.currentLocale(context!);
    for (var entry in state.materialSearchMap!.entries) {
       bool isContainsCategoryName = currentLocale==LanguageManager.instance.trLocale ?  entry.key.nameTR!.toLowerCase().contains(data) : entry.key.nameEN!.toLowerCase().contains(data);
      if (isContainsCategoryName) { 
        searchedMap?[entry.key] = entry.value;
      } else {
        for (var element in entry.value) {
           bool isContainsIngredient = currentLocale==LanguageManager.instance.trLocale ? element.nameTR!.toLowerCase().contains(data) : element.nameEN!.toLowerCase().contains(data);
          if (isContainsIngredient) {
            searchedMap![entry.key] = entry.value.where((element) => element.nameEN!.toLowerCase().contains(data)).toList();
          }
        }
      }
    }
     }
    emit(state.copyWith(materialSearchMap: searchedMap));
  }
  Future<void> fillMaterialSearchMap() async {
    Map<IngredientCategory, List<IngredientQuantity>>? materialSearchMap = {};
    var ingredientCategoryList = await fetchIngredientCategoryList();
    var ingredientList =  await fetchIngredientList();
    for (var category in ingredientCategoryList){
      var categoryData = category.data();
        List<IngredientQuantity> ingredientSameCategoryList = [];
     for(var ingredient in ingredientList){
      
     var ingredientData = ingredient.data();
      if(categoryData?.id == ingredientData?.categoryId && categoryData!=null && ingredientData!=null){
       
         ingredientSameCategoryList.add(ingredientData as IngredientQuantity);
      
      }     
     }
     if(categoryData!=null) {
       materialSearchMap[categoryData] = ingredientSameCategoryList;
     }
    }
     emit(state.copyWith(materialSearchMap: materialSearchMap));

  }
     Future<void> saveCacheMaterialSearchMap(
    MaterialSearchModel materialSearchModel,
  ) async {
    final IHiveManager<MaterialSearchModel> hiveManager = HiveManager<MaterialSearchModel>(HiveBoxEnum.materialSearchMap);
    await hiveManager.put(
      HiveKeyEnum.materialSearchMap,
      materialSearchModel,
    );
  }
    void changeIsLoadingState() {
      final loading = state.isLoading!;
    emit(state.copyWith(isLoading: !loading));
  }
     @override
     void setContext(BuildContext context) {
      this.context = context;
     }


}
class MaterialSearchCubit extends Cubit<IMaterialSearchState> implements IBaseViewModel {
  MaterialSearchCubit() : super(MaterialSearchInit());

  IMaterialSearchService? service;

  List<IngredientQuantity> essentials = [];
  List<IngredientQuantity> vegetables = [];
  List<IngredientQuantity> fruits = [];

  late TextEditingController searchTextController;
  late Map<CategoryOfIngredientModel, List<IngredientQuantity>>? searchedMap;
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
   /* final result = await service!.categoryOfIngredient();
    return result?.data?.ingredientCategoryList?.toList();*/
  }

  Future<List<IngredientQuantity>?> fetchIngredientsOfCategory(String categoryId) async {
   /* final result = await service!.ingredientsOfCategory(categoryId);
    return result?.data?.ingredientList?.toList();*/
  }

  void searchData(String data) {
    searchedMap?.clear();
    data = data.toLowerCase();
    for (var entry in materialSearchModel.materialSearchMap!.entries) {
      if (entry.key.categoryName!.toLowerCase().contains(data)) { 
        searchedMap?[entry.key] = entry.value;
      } else {
        for (var element in entry.value) {
          if (element.nameEN!.toLowerCase().contains(data)) {
            searchedMap?[entry.key] = entry.value.where((element) => element.nameEN!.toLowerCase().contains(data)).toList();
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
