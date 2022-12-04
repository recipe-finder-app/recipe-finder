import 'package:flutter/material.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/feature/material_search_page/model/product_model.dart';
import 'package:recipe_finder/product/component/image_format/image_png.dart';
import 'package:recipe_finder/product/component/text/locale_text.dart';

class SearchByMealCard extends StatelessWidget {
  const SearchByMealCard({Key? key, required ProductModel model})
      : _model = model,
        super(key: key);

  final ProductModel _model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.veryyHighValue,
      decoration: BoxDecoration(
        borderRadius: context.radiusAllCircularMin,
        color: _model.color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: context.paddingLowLeft,
            child: LocaleText(
              fontSize: 12,
              text: _model.title ?? '',
            ),
          ),
          SizedBox(
              child: ImagePng(
            path: _model.image ?? '',
          ))
        ],
      ),
    );
  }
}
