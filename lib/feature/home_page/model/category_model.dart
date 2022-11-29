import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/feature/material_search_page/model/product_model.dart';

import '../../../product/component/image_format/image_svg.dart';
import '../../../core/constant/enum/image_path_enum.dart';

// class CategoryModel {
//   final Widget imagePath;
//   final String title;
//   final Color color;

//   CategoryModel(
//       {required this.color, required this.imagePath, required this.title});
// }

class CategoryItems {
  late final List<ProductModel> categorys;

  CategoryItems() {
    categorys = [
      ProductModel(
          image: ImageSvg(
            path: ImagePath.pizza.path,
            height: 24,
          ),
          title: LocaleKeys.pizza,
          color: const Color(0xffcc8026).withOpacity(0.1)),
      ProductModel(
          image: ImageSvg(
            path: ImagePath.vegetarian.path,
            height: 24,
          ),
          title: LocaleKeys.vegetarian,
          color: const Color(0xff2b710a).withOpacity(0.1)),
      ProductModel(
          image: ImageSvg(
            path: ImagePath.muffin.path,
            height: 24,
          ),
          title: LocaleKeys.desserts,
          color: const Color(0xff8b4e05).withOpacity(0.1)),
      ProductModel(
          image: ImageSvg(
            path: ImagePath.chicken.path,
            height: 24,
          ),
          title: LocaleKeys.chicken,
          color: const Color(0xff8b3c03).withOpacity(0.1)),
      ProductModel(
          image: ImageSvg(
            path: ImagePath.pizza.path,
            height: 24,
          ),
          title: LocaleKeys.pizza,
          color: const Color(0xff212a34).withOpacity(0.1)),
      ProductModel(
          image: ImageSvg(
            path: ImagePath.muffin.path,
            height: 24,
          ),
          title: LocaleKeys.desserts,
          color: const Color(0xff8b4e05).withOpacity(0.1)),
      ProductModel(
          image: ImageSvg(
            path: ImagePath.chicken.path,
            height: 24,
          ),
          title: LocaleKeys.chicken,
          color: const Color(0xff8b3c03).withOpacity(0.1)),
      ProductModel(
          image: ImageSvg(
            path: ImagePath.pizza.path,
            height: 24,
          ),
          title: LocaleKeys.pizza,
          color: const Color(0xff212a34).withOpacity(0.1)),
    ];
  }
}
