import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import '../../../product/model/ingredient_quantity/ingredient_quantity.dart';

import '../../../product/utils/constant/image_path_enum.dart';

class CategoryItems {
  late final List<IngredientQuantity> categories;

  CategoryItems() {
    categories = [
      IngredientQuantity(imagePath: ImagePathConstant.pizza.path, nameEN: LocaleKeys.pizza, color: 0xffcc8026),
      IngredientQuantity(imagePath: ImagePathConstant.vegetarian.path, nameEN: LocaleKeys.vegetarian, color: 0xff2b710a),
      IngredientQuantity(imagePath: ImagePathConstant.muffin.path, nameEN: LocaleKeys.desserts, color: 0xff8b4e05),
      IngredientQuantity(imagePath: ImagePathConstant.chicken.path, nameEN: LocaleKeys.chicken, color: 0xff8b3c03),
      IngredientQuantity(imagePath: ImagePathConstant.pizza.path, nameEN: LocaleKeys.pizza, color: 0xff212a34),
      IngredientQuantity(imagePath: ImagePathConstant.muffin.path, nameEN: LocaleKeys.desserts, color: 0xff8b4e05),
      IngredientQuantity(imagePath: ImagePathConstant.chicken.path, nameEN: LocaleKeys.chicken, color: 0xff8b3c03),
      IngredientQuantity(imagePath: ImagePathConstant.pizza.path, nameEN: LocaleKeys.pizza, color: 0xff212a34),
    ];
  }
}
