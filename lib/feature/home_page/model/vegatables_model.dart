import 'package:recipe_finder/core/init/language/locale_keys.g.dart';

import '../../../product/model/ingredient_quantity/ingredient_quantity.dart';
import '../../../product/utils/constant/image_path_enum.dart';

class VegatablesItems {
  late final List<IngredientQuantity> vegatableItems;

  VegatablesItems() {
    vegatableItems = [
      IngredientQuantity(imagePath: ImagePathConstant.tomato.path, nameEN: LocaleKeys.tomato, color: 0xffa30909),
      IngredientQuantity(imagePath: ImagePathConstant.salad.path, nameEN: LocaleKeys.salad, color: 0xff519e1b),
      IngredientQuantity(imagePath: ImagePathConstant.potato.path, nameEN: LocaleKeys.potato, color: 0xffb7690d),
      IngredientQuantity(imagePath: ImagePathConstant.onion.path, nameEN: LocaleKeys.onion, color: 0xff9d5622),
      IngredientQuantity(imagePath: ImagePathConstant.broccoli.path, nameEN: LocaleKeys.broccoli, color: 0xff1a5b22),
      IngredientQuantity(imagePath: ImagePathConstant.carrot.path, nameEN: LocaleKeys.carrot, color: 0xffa44703),
      IngredientQuantity(imagePath: ImagePathConstant.eggplant.path, nameEN: LocaleKeys.eggplant, color: 0xff800771),
      IngredientQuantity(imagePath: ImagePathConstant.peas.path, nameEN: LocaleKeys.peas, color: 0xff61980a),
      IngredientQuantity(imagePath: ImagePathConstant.peas.path, nameEN: LocaleKeys.peas, color: 0xff61980a),
      IngredientQuantity(imagePath: ImagePathConstant.carrot.path, nameEN: LocaleKeys.carrot, color: 0xffa44703),
      IngredientQuantity(imagePath: ImagePathConstant.eggplant.path, nameEN: LocaleKeys.eggplant, color: 0xff800771),
      IngredientQuantity(imagePath: ImagePathConstant.peas.path, nameEN: LocaleKeys.peas, color: 0xff61980a),
      IngredientQuantity(imagePath: ImagePathConstant.peas.path, nameEN: LocaleKeys.peas, color: 0xff61980a),
    ];
  }
}
