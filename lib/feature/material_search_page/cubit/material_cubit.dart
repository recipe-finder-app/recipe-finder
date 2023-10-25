import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/init/language/language_manager.dart';
import 'package:recipe_finder/product/model/error_model.dart';
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

class MaterialSearchCubit extends Cubit<MaterialSearchState> implements IBaseViewModel {
   MaterialSearchCubit() : super(const MaterialSearchState(isLoading: false,isSearching: false, materialSearchMap: {},materialSearchSearchedMap: {},error: null));
   late TextEditingController searchTextController;
   late IMaterialSearchService service;
     @override
     BuildContext? context;
   
     @override
     void dispose() {
    searchTextController.dispose;
    stateClear();
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
     Future<List<QueryDocumentSnapshot<IngredientQuantity?>>> fetchIngredientList() async {
     final response = await service.fetchIngredientList().get();
     final responseDocs = response.docs;
    
     return responseDocs;
     }
   
  Future<void> fillMaterialSearchMap() async {
    try{
    changeIsLoadingState();
    Map<IngredientCategory, List<IngredientQuantity>>? materialSearchMap = {};
    var ingredientCategoryList = await fetchIngredientCategoryList();
    var ingredientList =  await fetchIngredientList();
    for (var category in ingredientCategoryList){
      var categoryData = category.data();
        List<IngredientQuantity> ingredientSameCategoryList = [];
     for(var ingredient in ingredientList){
      
     var ingredientData = ingredient.data();
   
      if(category.id == ingredientData?.categoryId && categoryData!=null && ingredientData!=null){
       
         ingredientSameCategoryList.add(ingredientData);
       materialSearchMap[categoryData] = ingredientSameCategoryList;
      }  
      
     }
    
    }

     emit(state.copyWith(materialSearchMap: materialSearchMap));
    }
    catch(e){
      emit(state.copyWith(error: BaseError(message: e.toString())));
    }
    finally{
 changeIsLoadingState();
    }

  }
    void searchData(String data) {
     emit(state.copyWith(materialSearchSearchedMap: {}));
     changeIsSearchingState(true);
     data = data.toLowerCase();
     Map<IngredientCategory, List<IngredientQuantity>>? searchedMap = {};
     if(context!=null){
     Locale currentLocale = context!.locale;
    for (var entry in state.materialSearchMap!.entries) {
       bool isContainsCategoryName = currentLocale==LanguageManager.instance.trLocale ?  entry.key.nameTR!.toLowerCase().contains(data) : entry.key.nameEN!.toLowerCase().contains(data);
      if (isContainsCategoryName) { 
        searchedMap[entry.key] = entry.value;
        print("entry.key${ searchedMap[entry.key]}");
      } else {
        for (var element in entry.value) {
           bool isContainsIngredient = currentLocale==LanguageManager.instance.trLocale ? element.nameTR!.toLowerCase().contains(data) : element.nameEN!.toLowerCase().contains(data);
          if (isContainsIngredient) {
           List<IngredientQuantity> filteredList = entry.value.where((element) {
  if (currentLocale == LanguageManager.instance.trLocale) {
    return element.nameTR!.toLowerCase().contains(data);
  } else {
    return element.nameEN!.toLowerCase().contains(data);
  }
}).toList();
           searchedMap[entry.key] = filteredList;
          }
        }
      }
    }
     }
    emit(state.copyWith(materialSearchSearchedMap: searchedMap));
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
   void changeIsSearchingState(bool isSearching) {
    emit(state.copyWith(isSearching: isSearching));
  }
  stateClear(){
     emit(state.copyWith(isLoading: false));
      emit(state.copyWith(isSearching: false));    
       emit(state.copyWith(materialSearchMap: {}));
        emit(state.copyWith(materialSearchSearchedMap: {}));
          emit(state.copyWith(error: const BaseError(message: '')));
  }
     @override
     void setContext(BuildContext context) {
      this.context = context;
     }


}
/*class MaterialSearchCubit extends Cubit<IMaterialSearchState> implements IBaseViewModel {
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
}*/
