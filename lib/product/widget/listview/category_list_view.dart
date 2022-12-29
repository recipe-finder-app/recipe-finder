import 'package:flutter/material.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';

import '../../../core/constant/design/color_constant.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../widget_core/text/locale_text.dart';

class DiscoverCategoryItems {
  late final List<String> categories;

  DiscoverCategoryItems() {
    categories = [
      LocaleKeys.all,
      LocaleKeys.breakfast,
      LocaleKeys.lunch,
      LocaleKeys.dinner,
      LocaleKeys.desserts
    ];
  }
}

class CategoryListView extends StatefulWidget {
  final VoidCallback? onPressedAll;
  final VoidCallback? onPressedBreakfast;
  final VoidCallback? onPressedLunch;
  final VoidCallback? onPressedDinner;
  final VoidCallback? onPressedDesserts;
  const CategoryListView(
      {Key? key,
      this.onPressedAll,
      this.onPressedBreakfast,
      this.onPressedLunch,
      this.onPressedDinner,
      this.onPressedDesserts})
      : super(key: key);

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  int? _selectedCategoryIndex;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: DiscoverCategoryItems().categories.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(right: context.lowValue),
              child: InkWell(
                onTap: () {
                  onPressed(index);
                },
                child: Container(
                  constraints: const BoxConstraints(
                      maxWidth: double.infinity, minWidth: 50),
                  decoration: BoxDecoration(
                    border: _selectedCategoryIndex == index
                        ? null
                        : Border.all(color: Colors.black, width: 0.5),
                    color: categoryItemColor(index),
                    borderRadius: context.radiusAllCircularMedium,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: context.paddingLowEdges,
                      child: LocaleText(
                        text: DiscoverCategoryItems().categories[index],
                        style: TextStyle(
                            fontSize: 16, color: categoryTextColor(index)),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void changeSelectedCategoryIndex(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  void onPressed(int index) {
    changeSelectedCategoryIndex(index);
    switch (index) {
      case 0:
        widget.onPressedAll != null ? widget.onPressedAll!() : null;
        break;
      case 1:
        widget.onPressedLunch != null ? widget.onPressedLunch!() : null;
        break;
      case 2:
        widget.onPressedDinner != null ? widget.onPressedDinner!() : null;
        break;
      case 3:
        widget.onPressedDesserts != null ? widget.onPressedDesserts!() : null;
        break;
    }
  }

  Color categoryItemColor(int index) {
    if (index == _selectedCategoryIndex) {
      return ColorConstants.instance.oriolesOrange;
    } else {
      return Colors.white;
    }
  }

  Color categoryTextColor(int index) {
    if (index == _selectedCategoryIndex) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }
}
