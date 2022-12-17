import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/feature/material_search_page/model/material2_model.dart';
import 'package:recipe_finder/product/model/ingradient_model.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../../core/constant/enum/image_path_enum.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../service/material2_service.dart';
import 'material2_state.dart';

class MaterialSearch2Cubit extends Cubit<IMaterialSearch2State>
    implements IBaseViewModel {
  IMaterialSearch2Service? service;

  MaterialSearch2Cubit() : super(MaterialSearch2Init());

  List<IngredientModel> essentials = [];
  List<IngredientModel> vegetables = [];
  List<IngredientModel> fruits = [];
  late MaterialSearchModel materialSearchModel;
  late Map<MaterialSearchCategory, List<IngredientModel>>? searchedMap;
  late TextEditingController searchTextController;

  @override
  void init() {
    service = MaterialSearch2Service();
    searchTextController = TextEditingController();
    essentials = [
      IngredientModel(
        imagePath: ImagePath.egg.path,
        title: LocaleKeys.egg.locale,
      ),
      IngredientModel(
        imagePath: ImagePath.milk.path,
        title: LocaleKeys.milk.locale,
      ),
      IngredientModel(
        imagePath: ImagePath.bread.path,
        title: LocaleKeys.bread.locale,
      ),
    ];
    vegetables = [
      IngredientModel(
        imagePath: ImagePath.tomato.path,
        title: LocaleKeys.tomato.locale,
      ),
      IngredientModel(
        imagePath: ImagePath.salad.path,
        title: LocaleKeys.salad.locale,
      ),
      IngredientModel(
        imagePath: ImagePath.potato.path,
        title: LocaleKeys.potato.locale,
      ),
    ];
    fruits = [
      IngredientModel(
        imagePath: ImagePath.tomato.path,
        title: LocaleKeys.broccoli.locale,
      ),
      IngredientModel(
        imagePath: ImagePath.milk.path,
        title: LocaleKeys.carrot.locale,
      ),
      IngredientModel(
        imagePath: ImagePath.potato.path,
        title: LocaleKeys.pizza.locale,
      ),
    ];
    materialSearchModel = MaterialSearchModel(materialSearchMap: {
      MaterialSearchCategory.essentials: essentials,
      MaterialSearchCategory.vegatables: vegetables,
      MaterialSearchCategory.fruits: fruits
    });
    searchedMap = {};
  }

  void searchData(String data) {
    searchedMap?.clear();
    data = data.toLowerCase();
    for (var entry in materialSearchModel.materialSearchMap.entries) {
      for (var element in entry.value) {
        if (element.title.toLowerCase().contains(data)) {
          searchedMap?[entry.key] = entry.value
              .where((element) => element.title.toLowerCase().contains(data))
              .toList();
          for (var i in entry.value) {
            print(i.title);
          }
        }
      }
    }
    emit(SearchedIngredientListLoad(searchedMap));
  }

  void ingredientListLoad() {
    emit(IngredientListLoad(materialSearchModel.materialSearchMap));
  }

  @override
  BuildContext? context;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
