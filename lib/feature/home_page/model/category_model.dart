import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/model/ingradient_model.dart';

import '../../../core/constant/enum/image_path_enum.dart';

// class CategoryModel {
//   final Widget imagePath;
//   final String title;
//   final Color color;

//   CategoryModel(
//       {required this.color, required this.imagePath, required this.title});
// }

class CategoryItems {
  late final List<IngredientModel> categories;

  CategoryItems() {
    categories = [
      IngredientModel(
          imagePath: ImagePath.pizza.path,
          title: LocaleKeys.pizza,
          color: const Color(0xffcc8026).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.vegetarian.path,
          title: LocaleKeys.vegetarian,
          color: const Color(0xff2b710a).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.muffin.path,
          title: LocaleKeys.desserts,
          color: const Color(0xff8b4e05).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.chicken.path,
          title: LocaleKeys.chicken,
          color: const Color(0xff8b3c03).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.pizza.path,
          title: LocaleKeys.pizza,
          color: const Color(0xff212a34).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.muffin.path,
          title: LocaleKeys.desserts,
          color: const Color(0xff8b4e05).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.chicken.path,
          title: LocaleKeys.chicken,
          color: const Color(0xff8b3c03).withOpacity(0.1)),
      IngredientModel(
          imagePath: ImagePath.pizza.path,
          title: LocaleKeys.pizza,
          color: const Color(0xff212a34).withOpacity(0.1)),
    ];
  }
}
