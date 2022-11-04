import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/feature/home/bottom_nav_bar_controller/bottom_nav_bar_cubit.dart';

import '../../../feature/authentication/login/cubit/login_cubit.dart';

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
      lazy: true,
    ),
    BlocProvider(
      create: (context) => RecipeNavigationBarCubit(),
      lazy: true,
    ),
  ];
}
