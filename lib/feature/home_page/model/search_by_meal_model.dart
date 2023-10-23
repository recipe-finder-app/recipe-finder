import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import '../../../product/model/ingredient_quantity/ingredient_quantity.dart';
import '../../../product/utils/constant/image_path_enum.dart';

class SearchByMealItems {
  late final List<IngredientQuantity> searchByMeals;

  SearchByMealItems() {
    searchByMeals = [
      IngredientQuantity(imagePath: ImagePathConstant.breakfast.path, nameEN: LocaleKeys.breakfast, color: 0xffFBFFDF),
      IngredientQuantity(imagePath: ImagePathConstant.lunch.path, nameEN: LocaleKeys.lunch, color: 0xffFAEAEA),
      IngredientQuantity(imagePath: ImagePathConstant.dinner.path, nameEN: LocaleKeys.dinner, color: 0xffF2EBDF),
      IngredientQuantity(imagePath: ImagePathConstant.desserts.path, nameEN: LocaleKeys.desserts, color: 0xffF5E4EC),
      IngredientQuantity(imagePath: ImagePathConstant.drinks.path, nameEN: LocaleKeys.drinks, color: 0xffEAFAF7),
      IngredientQuantity(imagePath: ImagePathConstant.appetizers.path, nameEN: LocaleKeys.appetizers, color: 0xffEAECFA),
      IngredientQuantity(imagePath: ImagePathConstant.desserts.path, nameEN: LocaleKeys.desserts, color: 0xffF5E4EC),
      IngredientQuantity(imagePath: ImagePathConstant.drinks.path, nameEN: LocaleKeys.drinks, color: 0xffEAFAF7),
      IngredientQuantity(imagePath: ImagePathConstant.appetizers.path, nameEN: LocaleKeys.appetizers, color: 0xffEAECFA),
    ];
  }
}
