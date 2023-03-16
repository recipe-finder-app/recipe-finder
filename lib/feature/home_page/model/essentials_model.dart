import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/model/ingredient/ingredient_model.dart';

import '../../../core/constant/enum/image_path_enum.dart';

class EssentialItems {
  late final List<IngredientModel> essentialItems;

  EssentialItems() {
    essentialItems = [
      IngredientModel(imagePath: ImagePath.egg.path, title: LocaleKeys.egg, color: 0xff968960),
      IngredientModel(imagePath: ImagePath.milk.path, title: LocaleKeys.milk, color: 0xff127aa7),
      IngredientModel(imagePath: ImagePath.bread.path, title: LocaleKeys.bread, color: 0xffb7690d),
      IngredientModel(imagePath: ImagePath.fish.path, title: LocaleKeys.fish, color: 0xff3388ac),
      IngredientModel(imagePath: ImagePath.egg.path, title: LocaleKeys.egg, color: 0xff968960),
    ];
  }
}
