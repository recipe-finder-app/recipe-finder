import 'package:flutter/material.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/feature/material_search_page/model/product_model.dart';

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
  late final List<ProductModel> vegatableItems;

  VegatablesItems() {
    vegatableItems = [
      ProductModel(
          image: ImageSvg(
            path: ImagePath.tomato.path,
            height: 24,
          ),
          title: LocaleKeys.tomato,
          color: const Color(0xffa30909).withOpacity(0.1)),
      ProductModel(
          image: ImageSvg(
            path: ImagePath.salad.path,
            height: 24,
          ),
          title: LocaleKeys.salad,
          color: const Color(0xff519e1b).withOpacity(0.1)),
      ProductModel(
          image: ImageSvg(
            path: ImagePath.potato.path,
            height: 24,
          ),
          title: LocaleKeys.potato,
          color: const Color(0xffb7690d).withOpacity(0.1)),
      ProductModel(
          image: ImageSvg(
            path: ImagePath.onion.path,
            height: 24,
          ),
          title: LocaleKeys.onion,
          color: const Color(0xff9d5622).withOpacity(0.1)),
      ProductModel(
          image: ImageSvg(
            path: ImagePath.broccoli.path,
            height: 24,
          ),
          title: LocaleKeys.broccoli,
          color: const Color(0xff1a5b22).withOpacity(0.1)),
      ProductModel(
          image: ImageSvg(
            path: ImagePath.carrot.path,
            height: 24,
          ),
          title: LocaleKeys.carrot,
          color: const Color(0xffa44703).withOpacity(0.1)),
      ProductModel(
          image: ImageSvg(
            path: ImagePath.eggplant.path,
            height: 24,
          ),
          title: LocaleKeys.eggplant,
          color: const Color(0xff800771).withOpacity(0.1)),
      ProductModel(
          image: ImageSvg(
            path: ImagePath.peas.path,
            height: 24,
          ),
          title: LocaleKeys.peas,
          color: const Color(0xff61980a).withOpacity(0.1)),
      ProductModel(
          image: ImageSvg(
            path: ImagePath.peas.path,
            height: 24,
          ),
          title: LocaleKeys.peas,
          color: const Color(0xff61980a).withOpacity(0.1)),
    ];
  }
}
