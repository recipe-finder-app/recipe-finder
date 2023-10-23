import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/model/ingredient/ingredient_model.dart';

import '../../../product/utils/constant/image_path_enum.dart';

class CategoryItems {
  late final List<IngredientModel> categories;

  CategoryItems() {
    categories = [
      IngredientModel(imagePath: ImagePathConstant.pizza.path, nameEN: LocaleKeys.pizza, color: 0xffcc8026),
      IngredientModel(imagePath: ImagePathConstant.vegetarian.path, nameEN: LocaleKeys.vegetarian, color: 0xff2b710a),
      IngredientModel(imagePath: ImagePathConstant.muffin.path, nameEN: LocaleKeys.desserts, color: 0xff8b4e05),
      IngredientModel(imagePath: ImagePathConstant.chicken.path, nameEN: LocaleKeys.chicken, color: 0xff8b3c03),
      IngredientModel(imagePath: ImagePathConstant.pizza.path, nameEN: LocaleKeys.pizza, color: 0xff212a34),
      IngredientModel(imagePath: ImagePathConstant.muffin.path, nameEN: LocaleKeys.desserts, color: 0xff8b4e05),
      IngredientModel(imagePath: ImagePathConstant.chicken.path, nameEN: LocaleKeys.chicken, color: 0xff8b3c03),
      IngredientModel(imagePath: ImagePathConstant.pizza.path, nameEN: LocaleKeys.pizza, color: 0xff212a34),
    ];
  }
}
