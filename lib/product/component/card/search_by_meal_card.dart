import 'package:flutter/material.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/feature/home_page/model/search_model.dart';
import 'package:recipe_finder/product/component/text/locale_text.dart';

class SearchByMealCard extends StatelessWidget {
  const SearchByMealCard({Key? key, required SearchModel model})
      : _model = model,
        super(key: key);

  final SearchModel _model;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: context.radiusAllCircularMin,
        color: _model.color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: context.paddingLowLeft,
            child: LocaleText(text: _model.title),
          ),
          _model.imagePath
        ],
      ),
    );
  }
}
