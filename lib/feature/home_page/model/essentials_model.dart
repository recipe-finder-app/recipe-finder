import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';

import '../../../product/component/image_format/image_svg.dart';
import '../../../core/constant/enum/image_path_enum.dart';

class EssentialModel {
  final Widget imagePath;
  final String title;
  final Color color;

  EssentialModel(
      {required this.color, required this.imagePath, required this.title});
}

class EssentialItems {
  late final List<EssentialModel> items;

  EssentialItems() {
    items = [
      EssentialModel(
          imagePath: ImageSvg(
            path: ImagePath.egg.path,
            height: 24,
          ),
          title: LocaleKeys.egg,
          color: const Color(0xff968960).withOpacity(0.1)),
      EssentialModel(
          imagePath: ImageSvg(
            path: ImagePath.milk.path,
            height: 24,
          ),
          title: LocaleKeys.milk,
          color: const Color(0xff127aa7).withOpacity(0.1)),
      EssentialModel(
          imagePath: ImageSvg(
            path: ImagePath.bread.path,
            height: 24,
          ),
          title: LocaleKeys.bread,
          color: const Color(0xffb7690d).withOpacity(0.1)),
      EssentialModel(
          imagePath: ImageSvg(
            path: ImagePath.fish.path,
            height: 24,
          ),
          title: LocaleKeys.fish,
          color: const Color(0xff3388ac).withOpacity(0.1)),
      EssentialModel(
          imagePath: ImageSvg(
            path: ImagePath.egg.path,
            height: 24,
          ),
          title: LocaleKeys.egg,
          color: const Color(0xff968960).withOpacity(0.1)),
    ];
  }
}
