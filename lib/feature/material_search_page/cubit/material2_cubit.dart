import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void init() {
    service = MaterialSearch2Service();
    essentials = [
      IngredientModel(
        imagePath: ImagePath.egg.path,
        title: LocaleKeys.egg,
      ),
      IngredientModel(
        imagePath: ImagePath.milk.path,
        title: LocaleKeys.milk,
      ),
      IngredientModel(
        imagePath: ImagePath.bread.path,
        title: LocaleKeys.bread,
      )
    ];
    vegetables = [
      IngredientModel(
        imagePath: ImagePath.tomato.path,
        title: LocaleKeys.tomato,
      ),
      IngredientModel(
        imagePath: ImagePath.salad.path,
        title: LocaleKeys.salad,
      ),
      IngredientModel(
        imagePath: ImagePath.potato.path,
        title: LocaleKeys.potato,
      ),
    ];
    fruits = [
      IngredientModel(
        imagePath: ImagePath.tomato.path,
        title: LocaleKeys.tomato,
      ),
      IngredientModel(
        imagePath: ImagePath.milk.path,
        title: LocaleKeys.salad,
      ),
      IngredientModel(
        imagePath: ImagePath.potato.path,
        title: LocaleKeys.potato,
      ),
    ];
    materialSearchModel = MaterialSearchModel(materialSearchMap: {
      MaterialSearchCategory.essentials: essentials,
      MaterialSearchCategory.vegatables: vegetables,
      MaterialSearchCategory.fruits: fruits
    });
  }

  void searchData(String data) {
    var value = materialSearchModel.materialSearchMap.values.where(
        (ingredientList) => ingredientList
            .where((ingredient) => ingredient.title.contains(data))
            .toList()
            .isNotEmpty);

    // emit(IngredientListLoad(value));
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
