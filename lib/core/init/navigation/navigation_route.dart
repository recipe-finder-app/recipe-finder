import 'package:flutter/material.dart';
import 'package:recipe_finder/feature/authentication/login/view/login_view.dart';

import '/core/component/view/no_navigation_view.dart';
import '/core/constant/navigation/navigation_constants.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();

  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.LOGIN:
        return normalNavigate(const LoginView(), NavigationConstants.LOGIN);
      default:
        return MaterialPageRoute(
          builder: (context) => const NotFoundNavigationView(),
        );
    }
  }

  String? initialRoute() {
    return NavigationConstants.LOGIN;
  }

  MaterialPageRoute normalNavigate(Widget widget, String pageName) {
    return MaterialPageRoute(
        builder: (context) => widget,
        //analytciste görülecek olan sayfa ismi için pageName veriyoruz
        settings: RouteSettings(name: pageName));
  }
}
