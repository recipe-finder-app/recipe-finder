import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/component/image_format/image_png.dart';

import '../../../product/component/image_format/image_svg.dart';
import '../../../core/constant/enum/image_path_enum.dart';

class SearchModel {
  final Widget imagePath;
  final String title;
  final Color color;

  SearchModel(
      {required this.color, required this.imagePath, required this.title});
}

class SearchItems {
  late final List<SearchModel> items;

  SearchItems() {
    items = [
      SearchModel(
          imagePath: ImagePng(path: ImagePath.breakfast.path),
          title: LocaleKeys.breakfast,
          color: const Color(0xffFBFFDF)),
      SearchModel(
          imagePath:ImagePng(path: ImagePath.lunch.path),
          title: LocaleKeys.lunch,
          color: const Color(0xffFAEAEA)),
      SearchModel(
          imagePath: ImagePng(path: ImagePath.dinner.path),
          title: LocaleKeys.dinner,
          color: const Color(0xffF2EBDF)),
      SearchModel(
          imagePath: ImagePng(path: ImagePath.desserts.path),
          title: LocaleKeys.desserts,
          color: const Color(0xffF5E4EC)),
      SearchModel(
          imagePath: ImagePng(path: ImagePath.drinks.path),
          title: LocaleKeys.drinks,
          color: const Color(0xffEAFAF7)),
      SearchModel(
          imagePath: ImagePng(path: ImagePath.appetizers.path),
          title: LocaleKeys.appetizers,
          color: const Color(0xffEAECFA)),
    ];
  }
}
