import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/model/ingredient/ingredient_model.dart';

import '../../../core/constant/enum/image_path_enum.dart';

class CategoryItems {
  late final List<IngredientModel> categories;

  CategoryItems() {
    categories = [
      IngredientModel(imagePath: ImagePath.pizza.path, title: LocaleKeys.pizza, color: 0xffcc8026),
      IngredientModel(imagePath: ImagePath.vegetarian.path, title: LocaleKeys.vegetarian, color: 0xff2b710a),
      IngredientModel(imagePath: ImagePath.muffin.path, title: LocaleKeys.desserts, color: 0xff8b4e05),
      IngredientModel(imagePath: ImagePath.chicken.path, title: LocaleKeys.chicken, color: 0xff8b3c03),
      IngredientModel(imagePath: ImagePath.pizza.path, title: LocaleKeys.pizza, color: 0xff212a34),
      IngredientModel(imagePath: ImagePath.muffin.path, title: LocaleKeys.desserts, color: 0xff8b4e05),
      IngredientModel(imagePath: ImagePath.chicken.path, title: LocaleKeys.chicken, color: 0xff8b3c03),
      IngredientModel(imagePath: ImagePath.pizza.path, title: LocaleKeys.pizza, color: 0xff212a34),
    ];
  }
}
