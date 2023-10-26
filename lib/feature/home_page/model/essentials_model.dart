import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import '../../../product/model/ingredient_quantity/ingredient_quantity.dart';

import '../../../product/utils/constant/image_path_enum.dart';

class EssentialItems {
  late final List<IngredientQuantity> essentialItems;

  EssentialItems() {
    essentialItems = [
      IngredientQuantity(imageUrl: ImagePathConstant.egg.path, nameEN: LocaleKeys.egg, color: "968960"),
      IngredientQuantity(imageUrl: ImagePathConstant.milk.path, nameEN: LocaleKeys.milk, color: "127aa7"),
      IngredientQuantity(imageUrl: ImagePathConstant.bread.path, nameEN: LocaleKeys.bread, color: "b7690d"),
      IngredientQuantity(imageUrl: ImagePathConstant.fish.path, nameEN: LocaleKeys.fish, color: "3388ac"),
      IngredientQuantity(imageUrl: ImagePathConstant.egg.path, nameEN: LocaleKeys.egg, color: "968960"),
    ];
  }
}
