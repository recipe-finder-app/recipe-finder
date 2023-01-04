import 'package:flutter/material.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';

import '../../../core/constant/design/color_constant.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../widget_core/text/locale_text.dart';

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

class CategoryListView extends StatefulWidget {
  final VoidCallback? onPressedAll;
  final VoidCallback? onPressedBreakfast;
  final VoidCallback? onPressedLunch;
  final VoidCallback? onPressedDinner;
  final VoidCallback? onPressedDesserts;
  final RecipeCategory? initialSelectedCategory;
  const CategoryListView({Key? key, this.onPressedAll, this.onPressedBreakfast, this.onPressedLunch, this.onPressedDinner, this.onPressedDesserts, this.initialSelectedCategory}) : super(key: key);

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  late RecipeCategory _selectedCategory;

  @override
  void initState() {
    _selectedCategory = widget.initialSelectedCategory ?? RecipeCategory.All;
    onPressed(_selectedCategory);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: RecipeCategory.values.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(right: context.lowValue),
              child: InkWell(
                onTap: () {
                  onPressed(calculateSelectedCategory(index));
                },
                child: Container(
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
                        text: RecipeCategory.values[index].locale,
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
