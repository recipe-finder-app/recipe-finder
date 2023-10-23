import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/model/ingredient/ingredient_model.dart';

import '../../../product/utils/constant/image_path_enum.dart';

class EssentialItems {
  late final List<IngredientModel> essentialItems;

  EssentialItems() {
    essentialItems = [
      IngredientModel(imagePath: ImagePathConstant.egg.path, nameEN: LocaleKeys.egg, color: 0xff968960),
      IngredientModel(imagePath: ImagePathConstant.milk.path, nameEN: LocaleKeys.milk, color: 0xff127aa7),
      IngredientModel(imagePath: ImagePathConstant.bread.path, nameEN: LocaleKeys.bread, color: 0xffb7690d),
      IngredientModel(imagePath: ImagePathConstant.fish.path, nameEN: LocaleKeys.fish, color: 0xff3388ac),
      IngredientModel(imagePath: ImagePathConstant.egg.path, nameEN: LocaleKeys.egg, color: 0xff968960),
    ];
  }
}
