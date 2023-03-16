import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/model/ingredient/ingredient_model.dart';

import '../../../core/constant/enum/image_path_enum.dart';

class SearchByMealItems {
  late final List<IngredientModel> searchByMeals;

  SearchByMealItems() {
    searchByMeals = [
      IngredientModel(imagePath: ImagePath.breakfast.path, title: LocaleKeys.breakfast, color: 0xffFBFFDF),
      IngredientModel(imagePath: ImagePath.lunch.path, title: LocaleKeys.lunch, color: 0xffFAEAEA),
      IngredientModel(imagePath: ImagePath.dinner.path, title: LocaleKeys.dinner, color: 0xffF2EBDF),
      IngredientModel(imagePath: ImagePath.desserts.path, title: LocaleKeys.desserts, color: 0xffF5E4EC),
      IngredientModel(imagePath: ImagePath.drinks.path, title: LocaleKeys.drinks, color: 0xffEAFAF7),
      IngredientModel(imagePath: ImagePath.appetizers.path, title: LocaleKeys.appetizers, color: 0xffEAECFA),
      IngredientModel(imagePath: ImagePath.desserts.path, title: LocaleKeys.desserts, color: 0xffF5E4EC),
      IngredientModel(imagePath: ImagePath.drinks.path, title: LocaleKeys.drinks, color: 0xffEAFAF7),
      IngredientModel(imagePath: ImagePath.appetizers.path, title: LocaleKeys.appetizers, color: 0xffEAECFA),
    ];
  }
}
