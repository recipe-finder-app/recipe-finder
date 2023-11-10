import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/language_manager.dart';

import '../../../core/constant/design/color_constant.dart';
import '../../../core/widget/text/locale_text.dart';






class CategoryListView<T> extends StatefulWidget {
  final T? selectedCategory;
  final List<dynamic> categoryList;
  final ValueChanged<T>? onPressed;
  const CategoryListView(
      {Key? key,this.selectedCategory, required this.categoryList, this.onPressed})
      : super(key: key);

  @override
  State<CategoryListView> createState() => _CategoryListViewState<T>();
}

class _CategoryListViewState<T> extends State<CategoryListView<T>> {
  //late T _selectedCategory = widget.initialSelectedCategory ?? widget.categoryList[0];
  List<GlobalKey> _keys = [];
  @override
  void initState() {
    if (widget.categoryList.isNotEmpty) {
      _keys = List.generate(widget.categoryList.length, (index) => GlobalKey());//otomatik kaydırma için global key gerekli
   
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    if (widget.categoryList.isEmpty) {
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
              String categoryName = context.locale == LanguageManager.instance.trLocale ? (widget.categoryList[index]?.nameTR ?? '') : (widget.categoryList[index]?.nameEN ?? '');
              return Padding(
                padding: EdgeInsets.only(right: context.lowValue),
                child: InkWell(
                  borderRadius: context.radiusAllCircularMin,
                  onTap: () {
                    if (widget.onPressed != null) {
                      widget.onPressed!.call(calculateSelectedCategory(index));
                    }
                     scrollToCategory(index); 
                   // changeSelectedCategory(calculateSelectedCategory(index));
                  
                  },
                  child: Container(
                    key: _keys[index],
                    constraints: const BoxConstraints(maxWidth: double.infinity, minWidth: 50),
                    decoration: BoxDecoration(
                      border: widget.selectedCategory == calculateSelectedCategory(index) ? null : Border.all(color: Colors.black, width: 0.5),
                      color: categoryItemColor(calculateSelectedCategory(index)),
                      borderRadius: context.radiusAllCircularMedium,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: context.paddingLowEdges,
                        child: LocaleText(
                          text:categoryName,
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

  /*void changeSelectedCategory(T category) {
    setState(() {
      _selectedCategory = category;
    });
  }*/

  void scrollToCategory(int index) {
   Scrollable.ensureVisible(
      _keys[index].currentContext!,
      duration: const Duration(seconds: 1),
      alignment: 0.5, // Scroll to the middle of the item.
    );
  }

  T calculateSelectedCategory(int index) {
    return widget.categoryList[index];
  }


  Color categoryItemColor(T category) {
    if (category == widget.selectedCategory) {
      return ColorConstants.instance.oriolesOrange;
    } else {
      return Colors.white;
    }
  }

  Color categoryTextColor(T category) {
    if (category == widget.selectedCategory) {
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
