import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import '../../../product/model/ingredient_quantity/ingredient_quantity.dart';

import '../../../product/utils/constant/image_path_enum.dart';

class CategoryItems {
  late final List<IngredientQuantity> categories;

  CategoryItems() {
    categories = [
      IngredientQuantity(imageUrl: ImagePathConstant.pizza.path, nameEN: LocaleKeys.pizza, color: "cc8026"),
      IngredientQuantity(imageUrl: ImagePathConstant.vegetarian.path, nameEN: LocaleKeys.vegetarian, color: "2b710a"),
      IngredientQuantity(imageUrl: ImagePathConstant.muffin.path, nameEN: LocaleKeys.desserts, color: "8b4e05"),
      IngredientQuantity(imageUrl: ImagePathConstant.chicken.path, nameEN: LocaleKeys.chicken, color: "8b3c03"),
      IngredientQuantity(imageUrl: ImagePathConstant.pizza.path, nameEN: LocaleKeys.pizza, color: "212a34"),
      IngredientQuantity(imageUrl: ImagePathConstant.muffin.path, nameEN: LocaleKeys.desserts, color: "8b4e05"),
      IngredientQuantity(imageUrl: ImagePathConstant.chicken.path, nameEN: LocaleKeys.chicken, color: "8b3c03"),
      IngredientQuantity(imageUrl: ImagePathConstant.pizza.path, nameEN: LocaleKeys.pizza, color: "212a34"),
    ];
  }
}
