import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/feature/material_search_page/model/product_model.dart';

import '../../../product/component/image_format/image_svg.dart';
import '../../../core/constant/enum/image_path_enum.dart';

/**
 * class MaterialEssentialModel {
  final Widget imagePath;
  final String title;
  final Color color;

  MaterialEssentialModel(
      {required this.color, required this.imagePath, required this.title});
}

 */
class MaterialEssentialItems {
  late final List<ProductModel> essentials;

  MaterialEssentialItems() {
    essentials = [
      ProductModel(
          image: ImagePath.egg.path,
          title: LocaleKeys.egg,
          color: const Color(0xff968960).withOpacity(0.1)),
      ProductModel(
          image: ImagePath.milk.path,
          title: LocaleKeys.milk,
          color: const Color(0xff127aa7).withOpacity(0.1)),
      ProductModel(
          image: ImagePath.bread.path,
          title: LocaleKeys.bread,
          color: const Color(0xffb7690d).withOpacity(0.1)),
      ProductModel(
          image: ImagePath.fish.path,
          title: LocaleKeys.fish,
          color: const Color(0xff3388ac).withOpacity(0.1)),
      ProductModel(
          image: ImagePath.milk.path,
          title: LocaleKeys.milk,
          color: const Color(0xff127aa7).withOpacity(0.1)),
      ProductModel(
          image: ImagePath.bread.path,
          title: LocaleKeys.bread,
          color: const Color(0xffb7690d).withOpacity(0.1)),
      ProductModel(
          image: ImagePath.fish.path,
          title: LocaleKeys.fish,
          color: const Color(0xff3388ac).withOpacity(0.1)),
      ProductModel(
          image: ImagePath.milk.path,
          title: LocaleKeys.milk,
          color: const Color(0xff127aa7).withOpacity(0.1)),
      ProductModel(
          image: ImagePath.bread.path,
          title: LocaleKeys.bread,
          color: const Color(0xffb7690d).withOpacity(0.1)),
    ];
  }
}
