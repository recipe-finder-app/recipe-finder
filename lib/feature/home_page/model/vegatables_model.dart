import 'package:recipe_finder/core/init/language/locale_keys.g.dart';

import '../../../product/model/ingredient_quantity/ingredient_quantity.dart';
import '../../../product/utils/constant/image_path_enum.dart';

class VegatablesItems {
  late final List<IngredientQuantity> vegatableItems;

  VegatablesItems() {
    vegatableItems = [
      IngredientQuantity(imageUrl: ImagePathConstant.tomato.path, nameEN: LocaleKeys.tomato, color: "a30909"),
      IngredientQuantity(imageUrl: ImagePathConstant.salad.path, nameEN: LocaleKeys.salad, color: "519e1b"),
      IngredientQuantity(imageUrl: ImagePathConstant.potato.path, nameEN: LocaleKeys.potato, color: "b7690d"),
      IngredientQuantity(imageUrl: ImagePathConstant.onion.path, nameEN: LocaleKeys.onion, color: "9d5622"),
      IngredientQuantity(imageUrl: ImagePathConstant.broccoli.path, nameEN: LocaleKeys.broccoli, color: "1a5b22"),
      IngredientQuantity(imageUrl: ImagePathConstant.carrot.path, nameEN: LocaleKeys.carrot, color: "a44703"),
      IngredientQuantity(imageUrl: ImagePathConstant.eggplant.path, nameEN: LocaleKeys.eggplant, color: "800771"),
      IngredientQuantity(imageUrl: ImagePathConstant.peas.path, nameEN: LocaleKeys.peas, color: "61980a"),
      IngredientQuantity(imageUrl: ImagePathConstant.peas.path, nameEN: LocaleKeys.peas, color: "61980a"),
      IngredientQuantity(imageUrl: ImagePathConstant.carrot.path, nameEN: LocaleKeys.carrot, color: "a44703"),
      IngredientQuantity(imageUrl: ImagePathConstant.eggplant.path, nameEN: LocaleKeys.eggplant, color: "800771"),
      IngredientQuantity(imageUrl: ImagePathConstant.peas.path, nameEN: LocaleKeys.peas, color: "61980a"),
      IngredientQuantity(imageUrl: ImagePathConstant.peas.path, nameEN: LocaleKeys.peas, color: "61980a"),
    ];
  }
}
