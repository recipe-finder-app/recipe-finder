import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/feature/material_search_page/model/material_model.dart';
import 'package:recipe_finder/product/model/ingradient_model.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../../core/constant/enum/image_path_enum.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../service/material_service.dart';
import 'material_state.dart';

class MaterialSearchCubit extends Cubit<IMaterialSearchState>
    implements IBaseViewModel {
  IMaterialSearchService? service;

  MaterialSearchCubit() : super(MaterialSearchInit());

  List<IngredientModel> essentials = [];
  List<IngredientModel> vegetables = [];
  List<IngredientModel> fruits = [];
  late MaterialSearchModel materialSearchModel;
  late Map<MaterialSearchCategory, List<IngredientModel>>? searchedMap;
  late TextEditingController searchTextController;

  @override
  void init() {
    service = MaterialSearchService();
    searchTextController = TextEditingController();
    essentials = [
      IngredientModel(
          imagePath: ImagePath.egg.path,
          title: LocaleKeys.egg.locale,
          color: const Color(0xff968960).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.milk.path,
          title: LocaleKeys.milk.locale,
          color: const Color(0xff127aa7).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.bread.path,
          title: LocaleKeys.bread.locale,
          color: const Color(0xffb7690d).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.fish.path,
          title: LocaleKeys.fish.locale,
          color: const Color(0xff3388ac).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.milk.path,
          title: LocaleKeys.milk.locale,
          color: const Color(0xff127aa7).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.bread.path,
          title: LocaleKeys.bread.locale,
          color: const Color(0xffb7690d).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.fish.path,
          title: LocaleKeys.fish.locale,
          color: const Color(0xff3388ac).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.milk.path,
          title: LocaleKeys.milk.locale,
          color: const Color(0xff127aa7).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.bread.path,
          title: LocaleKeys.bread.locale,
          color: const Color(0xffb7690d).withOpacity(0.1)),
    ];
    vegetables = [
      IngredientModel(
          imagePath: ImagePath.tomato.path,
          title: LocaleKeys.tomato.locale,
          color: const Color(0xffa30909).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.salad.path,
          title: LocaleKeys.salad.locale,
          color: const Color(0xff519e1b).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.potato.path,
          title: LocaleKeys.potato.locale,
          color: const Color(0xffb7690d).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.onion.path,
          title: LocaleKeys.onion.locale,
          color: const Color(0xff9d5622).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.broccoli.path,
          title: LocaleKeys.broccoli.locale,
          color: const Color(0xff1a5b22).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.carrot.path,
          title: LocaleKeys.carrot.locale,
          color: const Color(0xffa44703).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.eggplant.path,
          title: LocaleKeys.eggplant.locale,
          color: const Color(0xff800771).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.peas.path,
          title: LocaleKeys.peas.locale,
          color: const Color(0xff61980a).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.peas.path,
          title: LocaleKeys.peas.locale,
          color: const Color(0xff61980a).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.broccoli.path,
          title: LocaleKeys.broccoli.locale,
          color: const Color(0xff1a5b22).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.carrot.path,
          title: LocaleKeys.carrot.locale,
          color: const Color(0xffa44703).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.eggplant.path,
          title: LocaleKeys.eggplant.locale,
          color: const Color(0xff800771).withOpacity(0.1)),
    ];
    fruits = [
      IngredientModel(
          imagePath: ImagePath.tomato.path,
          title: LocaleKeys.tomato.locale,
          color: const Color(0xffa30909).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.salad.path,
          title: LocaleKeys.salad.locale,
          color: const Color(0xff519e1b).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.potato.path,
          title: LocaleKeys.potato.locale,
          color: const Color(0xffb7690d).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.onion.path,
          title: LocaleKeys.onion.locale,
          color: const Color(0xff9d5622).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.broccoli.path,
          title: LocaleKeys.broccoli.locale,
          color: const Color(0xff1a5b22).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.carrot.path,
          title: LocaleKeys.carrot.locale,
          color: const Color(0xffa44703).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.eggplant.path,
          title: LocaleKeys.eggplant.locale,
          color: const Color(0xff800771).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.peas.path,
          title: LocaleKeys.peas.locale,
          color: const Color(0xff61980a).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.peas.path,
          title: LocaleKeys.peas.locale,
          color: const Color(0xff61980a).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.broccoli.path,
          title: LocaleKeys.broccoli.locale,
          color: const Color(0xff1a5b22).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.carrot.path,
          title: LocaleKeys.carrot.locale,
          color: const Color(0xffa44703).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.eggplant.path,
          title: LocaleKeys.eggplant.locale,
          color: const Color(0xff800771).withOpacity(0.1)),
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
    for (var entry in materialSearchModel.materialSearchMap.entries) {
      for (var element in entry.value) {
        if (element.title.toLowerCase().contains(data.toLowerCase())) {
          searchedMap?[entry.key] = entry.value
              .where((element) => element.title.contains(data))
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
