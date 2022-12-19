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
    pageController.animateToPage(
      selectedPageIndex,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
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
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
        );
      }
    }
  }

  void clear() {
    selectedPageIndex = 0;
    emit(selectedPageIndex);
  }
}

/*class CustomPageRouteBuilder<T extends StatelessWidget>
    extends PageRouteBuilder {
  final T view;

  CustomPageRouteBuilder({required this.view})
      : super(
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(0.0, 1.0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) => view,
        );
}*/
/*
  void navigationPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(context, CustomPageRouteBuilder(view: const HomeView()));
        break;
      case 1:
        Navigator.push(
            context, CustomPageRouteBuilder(view: const DiscoverView()));
        break;
      case 2:
        Navigator.push(
            context, CustomPageRouteBuilder(view: const DiscoverView()));
        break;
      case 3:
        Navigator.push(
            context, CustomPageRouteBuilder(view: const LikesView()));
        break;
      case 4:
        Navigator.push(
            context, CustomPageRouteBuilder(view: const BasketView()));
        break;
    }
  }
*/
