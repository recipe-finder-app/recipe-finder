import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/base/view/base_cubit.dart';
import 'package:recipe_finder/feature/basket_page/cubit/basket_cubit.dart';
import 'package:recipe_finder/feature/discover_page/cubit/discover_cubit.dart';
import 'package:recipe_finder/feature/finder_page/cubit/finder_cubit.dart';
import 'package:recipe_finder/feature/home_page/cubit/home_cubit.dart';
import 'package:recipe_finder/feature/likes_page/cubit/likes_cubit.dart';
import 'package:recipe_finder/feature/material_search_page/cubit/material_cubit.dart';
import 'package:recipe_finder/feature/onboard_page/cubit/onboard_cubit.dart';
import 'package:recipe_finder/feature/recipe_detail_page/cubit/recipe_detail_cubit.dart';
import 'package:recipe_finder/feature/splash_page/cubit/splash_cubit.dart';
import 'package:recipe_finder/product/widget/bottom_nav_bar_controller/bottom_nav_bar_cubit.dart';
import 'package:recipe_finder/product/widget/modal_bottom_sheet/add_to_basket_bottom_sheet/cubit/add_to_basket_bottom_sheet_cubit.dart';

import '../../../feature/login_page/cubit/login_cubit.dart';

class ApplicationBloc {
  static final ApplicationBloc _instance = ApplicationBloc._init();
  static ApplicationBloc get instance => _instance;
  ApplicationBloc._init();

  /*static ApplicationBloc? _instance;
  static ApplicationBloc get instance => _instance ??= ApplicationBloc._init();
  ApplicationBloc._init();*/

  List<dynamic> dependItems = [
    BlocProvider(
      create: (context) => BaseCubit(),
    ),
    BlocProvider(
      create: (context) => SplashCubit(),
    ),
    BlocProvider(
      create: (context) => OnboardCubit(),
    ),
    BlocProvider(
      create: (context) => LoginCubit(),
    ),
    BlocProvider(
      create: (context) => RecipeNavigationBarCubit(),
    ),
    BlocProvider(
      create: (context) => LikesCubit(),
    ),
    BlocProvider(
      create: (context) => HomeCubit(),
    ),
    BlocProvider(
      create: (context) => MaterialSearchCubit(),
    ),
    BlocProvider(
      create: (context) => RecipeDetailCubit(),
    ),
    BlocProvider(
      create: (context) => FinderCubit(),
    ),
    BlocProvider(
      create: (context) => BasketCubit(),
    ),
    BlocProvider(
      create: (context) => DiscoverCubit(),
    ),
    BlocProvider(
      create: (context) => AddToBasketCubit(),
    ),
  ];
}
