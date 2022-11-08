import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recipe_finder/feature/basket_page/view/basket_view.dart';
import 'package:recipe_finder/feature/discover_page/view/discover_view.dart';
import 'package:recipe_finder/feature/finder_page/view/finder_view.dart';
import 'package:recipe_finder/feature/home_page/view/home_view.dart';
import 'package:recipe_finder/feature/likes_page/view/likes_view.dart';
import 'package:recipe_finder/main.dart';

mixin NavigatorCustom<T extends MyApp> on Widget {
  Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    List<String> filtered = routeSettings.name!.split("/");
    switch (filtered[1]) {
      case "/":
        return PageTransition(
          child: const HomeView(),
          type: PageTransitionType.fade,
          settings: routeSettings,
          //   reverseDuration: DurationItems.durationSmall(),
        );

      case 'discoverView':
        return PageTransition(
          child: const DiscoverView(),
          type: PageTransitionType.fade,
          settings: routeSettings,
          reverseDuration:const Duration(seconds: 0),
        );
      case 'likesView':
        return PageTransition(
          child: const LikesView(),
          type: PageTransitionType.fade,
          settings: routeSettings,
          reverseDuration:const Duration(seconds: 0),
        );

      case 'basketView':
        return PageTransition(
          child: const BasketView(),
          type: PageTransitionType.fade,
          settings: routeSettings,
          // reverseDuration: DurationItems.durationSmall(),
        );
      case 'finderView':
        return PageTransition(
          child: const FinderView(),
          type: PageTransitionType.fade,
          settings: routeSettings,
          // reverseDuration: DurationItems.durationSmall(),
        );
    }
    return null;
  }
}
