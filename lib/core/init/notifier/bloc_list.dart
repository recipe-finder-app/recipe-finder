import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/feature/likes_page/cubit/likes_cubit.dart';
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
      create: (context) => LoginCubit(),
    ),
    BlocProvider(
      create: (context) => RecipeNavigationBarCubit(),
    ),
    BlocProvider(
      create: (context) => LikesCubit(),
    ),
  ];
}
