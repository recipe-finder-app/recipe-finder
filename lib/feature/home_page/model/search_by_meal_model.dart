import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import '../../../product/model/ingredient_quantity/ingredient_quantity.dart';
import '../../../product/utils/constant/image_path_enum.dart';

class SearchByMealItems {
  late final List<IngredientQuantity> searchByMeals;

  SearchByMealItems() {
    searchByMeals = [
      IngredientQuantity(imageUrl: ImagePathConstant.breakfast.path, nameEN: LocaleKeys.breakfast, color: "FBFFDF"),
      IngredientQuantity(imageUrl: ImagePathConstant.lunch.path, nameEN: LocaleKeys.lunch, color: "FAEAEA"),
      IngredientQuantity(imageUrl: ImagePathConstant.dinner.path, nameEN: LocaleKeys.dinner, color: "F2EBDF"),
      IngredientQuantity(imageUrl: ImagePathConstant.desserts.path, nameEN: LocaleKeys.desserts, color: "F5E4EC"),
      IngredientQuantity(imageUrl: ImagePathConstant.drinks.path, nameEN: LocaleKeys.drinks, color: "EAFAF7"),
      IngredientQuantity(imageUrl: ImagePathConstant.appetizers.path, nameEN: LocaleKeys.appetizers, color: "EAECFA"),
      IngredientQuantity(imageUrl: ImagePathConstant.desserts.path, nameEN: LocaleKeys.desserts, color: "F5E4EC"),
      IngredientQuantity(imageUrl: ImagePathConstant.drinks.path, nameEN: LocaleKeys.drinks, color: "EAFAF7"),
      IngredientQuantity(imageUrl: ImagePathConstant.appetizers.path, nameEN: LocaleKeys.appetizers, color: "EAECFA"),
    ];
  }
}
