import 'package:flutter/material.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';

import '../../../core/constant/design/color_constant.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../core/widget/text/locale_text.dart';

class RecipeCategoryItems {
  late final List<String> categories;

  RecipeCategoryItems() {
    categories = [LocaleKeys.all, LocaleKeys.breakfast, LocaleKeys.lunch, LocaleKeys.dinner, LocaleKeys.desserts];
  }
}

enum RecipeCategory {
  All(LocaleKeys.all),
  Breakfast(LocaleKeys.breakfast),
  Lunch(LocaleKeys.lunch),
  Dinner(LocaleKeys.dinner),
  Desserts(LocaleKeys.desserts);

  const RecipeCategory(this.locale);
  final String locale;
}

typedef StringDynamicParameterValueChanged = void Function(String, dynamic);

class CategoryListView extends StatefulWidget {
  final VoidCallback? onPressedAll;
  final VoidCallback? onPressedBreakfast;
  final VoidCallback? onPressedLunch;
  final VoidCallback? onPressedDinner;
  final VoidCallback? onPressedDesserts;
  final String? initialSelectedCategory;
  final List<String> categoryList;
  final List<dynamic> categoryIdList;
  final StringDynamicParameterValueChanged? onPressed;
  const CategoryListView(
      {Key? key, this.onPressedAll, this.onPressedBreakfast, this.onPressedLunch, this.onPressedDinner, this.onPressedDesserts, this.initialSelectedCategory, required this.categoryList, required this.categoryIdList, this.onPressed})
      : super(key: key);

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  late String? _selectedCategory;
  List<GlobalKey>? _keys;
  @override
  void initState() {
    if (widget.categoryList.isNotEmpty) {
      _keys = List.generate(widget.categoryList.length, (index) => GlobalKey()); //otomatik kaydırma için global key gerekli
      _selectedCategory = widget.initialSelectedCategory ?? widget.categoryList[0];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.categoryList.isEmpty || _keys == null) {
      return const SizedBox.shrink();
    } else {
      return SizedBox(
        height: 40,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.categoryList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(right: context.lowValue),
                child: InkWell(
                  borderRadius: context.radiusAllCircularMin,
                  onTap: () {
                    if (widget.onPressed != null) {
                      widget.onPressed!.call(calculateSelectedCategory(index), calculateSelectedCategoryId(index));
                    }
                    changeSelectedCategory(calculateSelectedCategory(index));
                    scrollToCategory(index);
                  },
                  child: Container(
                    key: _keys![index],
                    constraints: const BoxConstraints(maxWidth: double.infinity, minWidth: 50),
                    decoration: BoxDecoration(
                      border: _selectedCategory == calculateSelectedCategory(index) ? null : Border.all(color: Colors.black, width: 0.5),
                      color: categoryItemColor(calculateSelectedCategory(index)),
                      borderRadius: context.radiusAllCircularMedium,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: context.paddingLowEdges,
                        child: LocaleText(
                          text: widget.categoryList[index].locale,
                          style: TextStyle(fontSize: 16, color: categoryTextColor(calculateSelectedCategory(index))),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      );
    }
  }

  void changeSelectedCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void scrollToCategory(int index) {
    Scrollable.ensureVisible(
      _keys![index].currentContext!,
      duration: const Duration(seconds: 1),
      alignment: 0.5, // Scroll to the middle of the item.
    );
  }

  String calculateSelectedCategory(int index) {
    return widget.categoryList[index];
  }

  dynamic calculateSelectedCategoryId(int index) {
    return widget.categoryIdList[index];
  }

  Color categoryItemColor(String category) {
    if (category == _selectedCategory) {
      return ColorConstants.instance.oriolesOrange;
    } else {
      return Colors.white;
    }
  }

  Color categoryTextColor(String category) {
    if (category == _selectedCategory) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }
}
/*
class CategoryListView extends StatefulWidget {
  final VoidCallback? onPressedAll;
  final VoidCallback? onPressedBreakfast;
  final VoidCallback? onPressedLunch;
  final VoidCallback? onPressedDinner;
  final VoidCallback? onPressedDesserts;
  final RecipeCategory? initialSelectedCategory;
  final List<String> categories;
  const CategoryListView({Key? key, this.onPressedAll, this.onPressedBreakfast, this.onPressedLunch, this.onPressedDinner, this.onPressedDesserts, this.initialSelectedCategory, required this.categories}) : super(key: key);

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  late RecipeCategory _selectedCategory;
  late List<GlobalKey> _keys;
  @override
  void initState() {
    _selectedCategory = widget.initialSelectedCategory ?? RecipeCategory.All;
    onPressed(_selectedCategory);
    _keys = List.generate(widget.categories.length, (index) => GlobalKey()); //otomatik kaydırma için global key gerekli
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: widget.categories.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(right: context.lowValue),
              child: InkWell(
                onTap: () {
                  onPressed(calculateSelectedCategory(index));
                  scrollToCategory(index);
                },
                child: Container(
                  key: _keys[index],
                  constraints: const BoxConstraints(maxWidth: double.infinity, minWidth: 50),
                  decoration: BoxDecoration(
                    border: _selectedCategory == calculateSelectedCategory(index) ? null : Border.all(color: Colors.black, width: 0.5),
                    color: categoryItemColor(calculateSelectedCategory(index)),
                    borderRadius: context.radiusAllCircularMedium,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: context.paddingLowEdges,
                      child: LocaleText(
                        text: widget.categories[index].locale,
                        style: TextStyle(fontSize: 16, color: categoryTextColor(calculateSelectedCategory(index))),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void changeSelectedCategory(RecipeCategory category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void scrollToCategory(int index) {
    Scrollable.ensureVisible(
      _keys[index].currentContext!,
      duration: Duration(seconds: 1),
      alignment: 0.5, // Scroll to the middle of the item.
    );
  }

  RecipeCategory calculateSelectedCategory(int index) {
    switch (index) {
      case 0:
        return RecipeCategory.All;
      case 1:
        return RecipeCategory.Breakfast;
      case 2:
        return RecipeCategory.Lunch;
      case 3:
        return RecipeCategory.Dinner;
      case 4:
        return RecipeCategory.Desserts;
      default:
        return RecipeCategory.All;
    }
  }

  void onPressed(RecipeCategory category) {
    changeSelectedCategory(category);
    switch (category.name) {
      case 'All':
        widget.onPressedAll != null ? widget.onPressedAll!() : null;
        break;
      case 'Breakfast':
        widget.onPressedBreakfast != null ? widget.onPressedBreakfast!() : null;
        break;
      case 'Lunch':
        widget.onPressedLunch != null ? widget.onPressedLunch!() : null;
        break;
      case 'Dinner':
        widget.onPressedDinner != null ? widget.onPressedDinner!() : null;
        break;
      case 'Desserts':
        widget.onPressedDesserts != null ? widget.onPressedDesserts!() : null;
        break;
    }
  }

  Color categoryItemColor(RecipeCategory category) {
    if (category == _selectedCategory) {
      return ColorConstants.instance.oriolesOrange;
    } else {
      return Colors.white;
    }
  }

  Color categoryTextColor(RecipeCategory category) {
    if (category == _selectedCategory) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }
}
*/
