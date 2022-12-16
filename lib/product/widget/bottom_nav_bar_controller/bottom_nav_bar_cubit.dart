import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/feature/finder_page/view/finder_view.dart';

import '../../../feature/basket_page/view/basket_view.dart';
import '../../../feature/discover_page/view/discover_view.dart';
import '../../../feature/home_page/view/home_view.dart';
import '../../../feature/likes_page/view/likes_view.dart';

class RecipeNavigationBarCubit extends Cubit<int> {
  var pageList = [
    const HomeView(),
    const DiscoverView(),
    const FinderView(),
    const LikesView(),
    const BasketView(),
  ];
  int selectedPageIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  RecipeNavigationBarCubit() : super(0);

  void clickSearchButton() {
    selectedPageIndex = 2;

    emit(selectedPageIndex);
  }

  Color itemColor(index) {
    if (index == selectedPageIndex) {
      return Colors.black;
    } else {
      return Colors.grey;
    }
  }

  void changeCurrentIndex(int index) {
    if (index >= 0 && index < pageList.length) {
      selectedPageIndex = index;
      emit(selectedPageIndex);
      if (pageController.hasClients) {
        pageController.animateToPage(
          selectedPageIndex,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.linear,
        );
      }
    }
  }

  void clear() {
    selectedPageIndex = 0;
    emit(selectedPageIndex);
  }
}
