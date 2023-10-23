import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import '../../../product/model/ingredient_quantity/ingredient_quantity.dart';

import '../../../product/utils/constant/image_path_enum.dart';

class EssentialItems {
  late final List<IngredientQuantity> essentialItems;

  EssentialItems() {
    essentialItems = [
      IngredientQuantity(imagePath: ImagePathConstant.egg.path, nameEN: LocaleKeys.egg, color: 0xff968960),
      IngredientQuantity(imagePath: ImagePathConstant.milk.path, nameEN: LocaleKeys.milk, color: 0xff127aa7),
      IngredientQuantity(imagePath: ImagePathConstant.bread.path, nameEN: LocaleKeys.bread, color: 0xffb7690d),
      IngredientQuantity(imagePath: ImagePathConstant.fish.path, nameEN: LocaleKeys.fish, color: 0xff3388ac),
      IngredientQuantity(imagePath: ImagePathConstant.egg.path, nameEN: LocaleKeys.egg, color: 0xff968960),
    ];
  }
}
