import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/feature/finder_page/cubit/finder_cubit.dart';
import 'package:recipe_finder/feature/home_page/cubit/home_cubit.dart';
import 'package:recipe_finder/feature/likes_page/cubit/likes_cubit.dart';
import 'package:recipe_finder/feature/material_search_page/cubit/material2_cubit.dart';
import 'package:recipe_finder/feature/material_search_page/cubit/material_cubit.dart';
import 'package:recipe_finder/feature/onboard_page/cubit/onboard_cubit.dart';
import 'package:recipe_finder/feature/recipe_detail_page/cubit/recipe_detail_cubit.dart';
import 'package:recipe_finder/product/widget/bottom_nav_bar_controller/bottom_nav_bar_cubit.dart';

import '../../../feature/login_page/cubit/login_cubit.dart';

class ApplicationBloc {
  static ApplicationBloc? _instance;
  static ApplicationBloc get instance {
    _instance ??= ApplicationBloc._init();
    return _instance!;
  }

  ApplicationBloc._init();

  List<dynamic> dependItems = [
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
      create: (context) => MaterialSearch2Cubit(),
    ),
  ];
}
