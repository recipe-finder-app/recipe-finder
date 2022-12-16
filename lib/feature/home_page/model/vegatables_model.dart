import 'package:flutter/material.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/model/ingradient_model.dart';
import '../../../product/component/image_format/image_svg.dart';
import '../../../core/constant/enum/image_path_enum.dart';

// class VegatablesModel {
//   final Widget imagePath;
//   final String title;
//   final Color color;

//   VegatablesModel(
//       {required this.color, required this.imagePath, required this.title});
// }

class VegatablesItems {
  late final List<IngredientModel> vegatableItems;

  VegatablesItems() {
    vegatableItems = [
      IngredientModel(
          imagePath: ImagePath.tomato.path,
          title: LocaleKeys.tomato,
          color: const Color(0xffa30909).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.salad.path,
          title: LocaleKeys.salad,
          color: const Color(0xff519e1b).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.potato.path,
          title: LocaleKeys.potato,
          color: const Color(0xffb7690d).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.onion.path,
          title: LocaleKeys.onion,
          color: const Color(0xff9d5622).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.broccoli.path,
          title: LocaleKeys.broccoli,
          color: const Color(0xff1a5b22).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.carrot.path,
          title: LocaleKeys.carrot,
          color: const Color(0xffa44703).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.eggplant.path,
          title: LocaleKeys.eggplant,
          color: const Color(0xff800771).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.peas.path,
          title: LocaleKeys.peas,
          color: const Color(0xff61980a).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.peas.path,
          title: LocaleKeys.peas,
          color: const Color(0xff61980a).withOpacity(0.1)),
    ];
  }
}
