import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/component/widget/alert_dialog/alert_dialog_no_connection.dart';
import 'core/constant/enum/network_result_enum.dart';
import 'core/constant/navigation/navigation_constants.dart';
import 'core/init/main_build/main_build.dart';
import 'core/init/navigation/navigation_route.dart';
import 'core/init/navigation/navigation_service.dart';
import 'core/init/network/connection_activity/network_change_manager.dart';
import 'core/init/notifier/bloc_list.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  await _init();
  runApp(const MyApp());
}

Future<void> _init() async {
  INetworkChangeManager networkChange = NetworkChangeManager();
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  final result = await networkChange.checkNetworkInitial();
  if (result == NetworkResult.off) {
    NoNetworkAlertDialog();
  } else {
    WidgetsFlutterBinding.ensureInitialized();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...ApplicationBloc.instance.dependItems],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Poppins'),
        builder: MainBuild.build,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: NavigationRoute.instance.generateRoute,
        navigatorKey: NavigationService.instance.navigatorKey,
        // initialRoute: NavigationRoute.instance.initialRoute(),
        initialRoute: NavigationConstants.LOGIN,
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
