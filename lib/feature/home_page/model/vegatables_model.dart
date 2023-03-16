import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/model/ingredient/ingredient_model.dart';

import '../../../core/constant/enum/image_path_enum.dart';

class VegatablesItems {
  late final List<IngredientModel> vegatableItems;

  VegatablesItems() {
    vegatableItems = [
      IngredientModel(imagePath: ImagePath.tomato.path, title: LocaleKeys.tomato, color: 0xffa30909),
      IngredientModel(imagePath: ImagePath.salad.path, title: LocaleKeys.salad, color: 0xff519e1b),
      IngredientModel(imagePath: ImagePath.potato.path, title: LocaleKeys.potato, color: 0xffb7690d),
      IngredientModel(imagePath: ImagePath.onion.path, title: LocaleKeys.onion, color: 0xff9d5622),
      IngredientModel(imagePath: ImagePath.broccoli.path, title: LocaleKeys.broccoli, color: 0xff1a5b22),
      IngredientModel(imagePath: ImagePath.carrot.path, title: LocaleKeys.carrot, color: 0xffa44703),
      IngredientModel(imagePath: ImagePath.eggplant.path, title: LocaleKeys.eggplant, color: 0xff800771),
      IngredientModel(imagePath: ImagePath.peas.path, title: LocaleKeys.peas, color: 0xff61980a),
      IngredientModel(imagePath: ImagePath.peas.path, title: LocaleKeys.peas, color: 0xff61980a),
      IngredientModel(imagePath: ImagePath.carrot.path, title: LocaleKeys.carrot, color: 0xffa44703),
      IngredientModel(imagePath: ImagePath.eggplant.path, title: LocaleKeys.eggplant, color: 0xff800771),
      IngredientModel(imagePath: ImagePath.peas.path, title: LocaleKeys.peas, color: 0xff61980a),
      IngredientModel(imagePath: ImagePath.peas.path, title: LocaleKeys.peas, color: 0xff61980a),
    ];
  }
}
