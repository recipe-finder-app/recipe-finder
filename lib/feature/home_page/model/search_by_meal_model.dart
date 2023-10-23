import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/model/ingredient/ingredient_model.dart';

import '../../../product/utils/constant/image_path_enum.dart';

class SearchByMealItems {
  late final List<IngredientModel> searchByMeals;

  SearchByMealItems() {
    searchByMeals = [
      IngredientModel(imagePath: ImagePathConstant.breakfast.path, nameEN: LocaleKeys.breakfast, color: 0xffFBFFDF),
      IngredientModel(imagePath: ImagePathConstant.lunch.path, nameEN: LocaleKeys.lunch, color: 0xffFAEAEA),
      IngredientModel(imagePath: ImagePathConstant.dinner.path, nameEN: LocaleKeys.dinner, color: 0xffF2EBDF),
      IngredientModel(imagePath: ImagePathConstant.desserts.path, nameEN: LocaleKeys.desserts, color: 0xffF5E4EC),
      IngredientModel(imagePath: ImagePathConstant.drinks.path, nameEN: LocaleKeys.drinks, color: 0xffEAFAF7),
      IngredientModel(imagePath: ImagePathConstant.appetizers.path, nameEN: LocaleKeys.appetizers, color: 0xffEAECFA),
      IngredientModel(imagePath: ImagePathConstant.desserts.path, nameEN: LocaleKeys.desserts, color: 0xffF5E4EC),
      IngredientModel(imagePath: ImagePathConstant.drinks.path, nameEN: LocaleKeys.drinks, color: 0xffEAFAF7),
      IngredientModel(imagePath: ImagePathConstant.appetizers.path, nameEN: LocaleKeys.appetizers, color: 0xffEAECFA),
    ];
  }
}
