import 'package:flutter_bloc/flutter_bloc.dart';

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
  ];
}
