import 'package:flutter/material.dart';
import 'package:recipe_finder/feature/drawer_page/view/about_us_view.dart';
import 'package:recipe_finder/feature/drawer_page/view/change_password.dart';
import 'package:recipe_finder/feature/drawer_page/view/change_username_view.dart';
import 'package:recipe_finder/feature/drawer_page/view/my_account_view.dart';
import 'package:recipe_finder/feature/finder_page/view/finder_view.dart';
import 'package:recipe_finder/feature/login_page/view/login_view.dart';
import 'package:recipe_finder/feature/onboard_page/view/onboard_view.dart';
import 'package:recipe_finder/feature/splash_page/view/splash_view.dart';
import 'package:recipe_finder/product/model/recipe/recipe.dart';

import '../../../product/utils/constant/navigation_constant.dart';
import '../../../feature/basket_page/view/basket_view.dart';
import '../../../feature/discover_page/view/discover_view.dart';
import '../../../feature/home_page/view/home_view.dart';
import '../../../feature/likes_page/view/likes_view.dart';
import '../../../feature/material_search_page/view/material_search_view.dart';
import '../../../feature/recipe_detail_page/view/recipe_detail_view.dart';
import '../../../product/widget/bottom_nav_bar_controller/recipe_bottom_navigation_bar.dart';
import '../../widget/no_navigation/no_navigation_view.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();

  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstant.SPLASH:
        return normalNavigate(const SplashView(), NavigationConstant.SPLASH);

      case NavigationConstant.ONBOARD:
        return normalNavigate(OnboardView(), NavigationConstant.ONBOARD);
      case NavigationConstant.LOGIN:
        return normalNavigate(LoginView(), NavigationConstant.LOGIN);
      case NavigationConstant.NAV_CONTROLLER:
        return normalNavigate(const RecipeBottomNavigationBar(), NavigationConstant.NAV_CONTROLLER);
      case NavigationConstant.HOME:
        return normalNavigate(const HomeView(), NavigationConstant.HOME);
      case NavigationConstant.DISCOVER:
        return normalNavigate(DiscoverView(), NavigationConstant.DISCOVER);
      case NavigationConstant.LIKES:
        return normalNavigate(LikesView(), NavigationConstant.LIKES);
      case NavigationConstant.BASKET:
        return normalNavigate(const BasketView(), NavigationConstant.BASKET);
      case NavigationConstant.MATERIALSEARCH:
        return normalNavigate(const MaterialSearchView(), NavigationConstant.MATERIALSEARCH);
      case NavigationConstant.RECIPE_DETAIL:
        return normalNavigate(RecipeDetailView(recipeModel: args.arguments as Recipe), NavigationConstant.RECIPE_DETAIL);
      case NavigationConstant.FINDER:
        return normalNavigate(const FinderView(), NavigationConstant.FINDER);
      case NavigationConstant.ABOUTUS:
        return normalNavigate(const DrawerAboutUsView(), NavigationConstant.ABOUTUS);
      case NavigationConstant.MYACCOUNT:
        return normalNavigate(const DrawerMyAccountView(), NavigationConstant.MYACCOUNT);
      case NavigationConstant.CHANGEUSERNAME:
        return normalNavigate(const DrawerChangeUsernameView(), NavigationConstant.CHANGEUSERNAME);
      case NavigationConstant.CHANGEPASSWORD:
        return normalNavigate(const DrawerChangePasswordView(), NavigationConstant.CHANGEPASSWORD);

      default:
        return MaterialPageRoute(
          builder: (context) => const NotFoundNavigationView(),
        );
    }
  }

  String? initialRoute() {
    return NavigationConstant.LOGIN;
  }

  MaterialPageRoute normalNavigate(Widget widget, String pageName) {
    return MaterialPageRoute(
        builder: (context) => widget,
        //analytciste görülecek olan sayfa ismi için pageName veriyoruz
        settings: RouteSettings(name: pageName));
  }

  MaterialPageRoute argNavigate(Widget widget, String pageName, String data) {
    return MaterialPageRoute(
        builder: (context) => widget,
        //analytciste görülecek olan sayfa ismi için pageName veriyoruz
        settings: RouteSettings(name: pageName, arguments: data));
  }
}
