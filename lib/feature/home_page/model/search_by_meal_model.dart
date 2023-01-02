import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/model/ingradient_model.dart';

import '../../../core/constant/enum/image_path_enum.dart';

// class SearchByMealModel {
//   final Widget imagePath;
//   final String title;
//   final Color color;

//   SearchByMealModel(
//       {required this.color, required this.imagePath, required this.title});
// }

class SearchByMealItems {
  late final List<IngredientModel> searchByMeals;

  SearchByMealItems() {
    searchByMeals = [
      IngredientModel(
          imagePath: ImagePath.breakfast.path,
          title: LocaleKeys.breakfast,
          color: const Color(0xffFBFFDF)),
      IngredientModel(
          imagePath: ImagePath.lunch.path,
          title: LocaleKeys.lunch,
          color: const Color(0xffFAEAEA)),
      IngredientModel(
          imagePath: ImagePath.dinner.path,
          title: LocaleKeys.dinner,
          color: const Color(0xffF2EBDF)),
      IngredientModel(
          imagePath: ImagePath.desserts.path,
          title: LocaleKeys.desserts,
          color: const Color(0xffF5E4EC)),
      IngredientModel(
          imagePath: ImagePath.drinks.path,
          title: LocaleKeys.drinks,
          color: const Color(0xffEAFAF7)),
      IngredientModel(
          imagePath: ImagePath.appetizers.path,
          title: LocaleKeys.appetizers,
          color: const Color(0xffEAECFA)),
      IngredientModel(
          imagePath: ImagePath.desserts.path,
          title: LocaleKeys.desserts,
          color: const Color(0xffF5E4EC)),
      IngredientModel(
          imagePath: ImagePath.drinks.path,
          title: LocaleKeys.drinks,
          color: const Color(0xffEAFAF7)),
      IngredientModel(
          imagePath: ImagePath.appetizers.path,
          title: LocaleKeys.appetizers,
          color: const Color(0xffEAECFA)),
    ];
  }
}
