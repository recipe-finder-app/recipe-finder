import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/feature/material_search_page/model/product_model.dart';
import 'package:recipe_finder/product/component/image_format/image_png.dart';
import '../../../core/constant/enum/image_path_enum.dart';

// class SearchByMealModel {
//   final Widget imagePath;
//   final String title;
//   final Color color;

//   SearchByMealModel(
//       {required this.color, required this.imagePath, required this.title});
// }

class SearchByMealItems {
  late final List<ProductModel> searchByMeals;

  SearchByMealItems() {
    searchByMeals = [
      ProductModel(
          image: ImagePng(path: ImagePath.breakfast.path),
          title: LocaleKeys.breakfast,
          color: const Color(0xffFBFFDF)),
      ProductModel(
          image: ImagePng(path: ImagePath.lunch.path),
          title: LocaleKeys.lunch,
          color: const Color(0xffFAEAEA)),
      ProductModel(
          image: ImagePng(path: ImagePath.dinner.path),
          title: LocaleKeys.dinner,
          color: const Color(0xffF2EBDF)),
      ProductModel(
          image: ImagePng(path: ImagePath.desserts.path),
          title: LocaleKeys.desserts,
          color: const Color(0xffF5E4EC)),
      ProductModel(
          image: ImagePng(path: ImagePath.drinks.path),
          title: LocaleKeys.drinks,
          color: const Color(0xffEAFAF7)),
      ProductModel(
          image: ImagePng(path: ImagePath.appetizers.path),
          title: LocaleKeys.appetizers,
          color: const Color(0xffEAECFA)),
    ];
  }
}
