import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/model/ingradient_model.dart';
import '../../../product/component/image_format/image_svg.dart';
import '../../../core/constant/enum/image_path_enum.dart';

// class EssentialModel {
//   final Widget imagePath;
//   final String title;
//   final Color color;

//   EssentialModel(
//       {required this.color, required this.imagePath, required this.title});
// }

class EssentialItems {
  late final List<IngredientModel> essentialItems;

  EssentialItems() {
    essentialItems = [
      IngredientModel(
          imagePath: ImagePath.egg.path,
          title: LocaleKeys.egg,
          color: const Color(0xff968960).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.milk.path,
          title: LocaleKeys.milk,
          color: const Color(0xff127aa7).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.bread.path,
          title: LocaleKeys.bread,
          color: const Color(0xffb7690d).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.fish.path,
          title: LocaleKeys.fish,
          color: const Color(0xff3388ac).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.egg.path,
          title: LocaleKeys.egg,
          color: const Color(0xff968960).withOpacity(0.1)),
    ];
  }
}
