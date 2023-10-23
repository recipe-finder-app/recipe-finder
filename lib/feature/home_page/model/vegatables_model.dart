import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/model/ingredient/ingredient_model.dart';

import '../../../product/utils/constant/image_path_enum.dart';

class VegatablesItems {
  late final List<IngredientModel> vegatableItems;

  VegatablesItems() {
    vegatableItems = [
      IngredientModel(imagePath: ImagePathConstant.tomato.path, nameEN: LocaleKeys.tomato, color: 0xffa30909),
      IngredientModel(imagePath: ImagePathConstant.salad.path, nameEN: LocaleKeys.salad, color: 0xff519e1b),
      IngredientModel(imagePath: ImagePathConstant.potato.path, nameEN: LocaleKeys.potato, color: 0xffb7690d),
      IngredientModel(imagePath: ImagePathConstant.onion.path, nameEN: LocaleKeys.onion, color: 0xff9d5622),
      IngredientModel(imagePath: ImagePathConstant.broccoli.path, nameEN: LocaleKeys.broccoli, color: 0xff1a5b22),
      IngredientModel(imagePath: ImagePathConstant.carrot.path, nameEN: LocaleKeys.carrot, color: 0xffa44703),
      IngredientModel(imagePath: ImagePathConstant.eggplant.path, nameEN: LocaleKeys.eggplant, color: 0xff800771),
      IngredientModel(imagePath: ImagePathConstant.peas.path, nameEN: LocaleKeys.peas, color: 0xff61980a),
      IngredientModel(imagePath: ImagePathConstant.peas.path, nameEN: LocaleKeys.peas, color: 0xff61980a),
      IngredientModel(imagePath: ImagePathConstant.carrot.path, nameEN: LocaleKeys.carrot, color: 0xffa44703),
      IngredientModel(imagePath: ImagePathConstant.eggplant.path, nameEN: LocaleKeys.eggplant, color: 0xff800771),
      IngredientModel(imagePath: ImagePathConstant.peas.path, nameEN: LocaleKeys.peas, color: 0xff61980a),
      IngredientModel(imagePath: ImagePathConstant.peas.path, nameEN: LocaleKeys.peas, color: 0xff61980a),
    ];
  }
}
