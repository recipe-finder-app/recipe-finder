import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:recipe_finder/core/init/navigation/navigation_route.dart';
import 'package:recipe_finder/core/init/navigation/navigation_service.dart';

import 'core/constant/app/app_constants.dart';
import 'core/constant/enum/network_result_enum.dart';
import 'core/constant/navigation/navigation_constants.dart';
import 'core/init/language/language_manager.dart';
import 'core/init/main_build/main_build.dart';
import 'core/init/network/connection_activity/network_change_manager.dart';
import 'core/init/notifier/bloc_list.dart';
import 'product/widget_core/alert_dialog/alert_dialog_no_connection.dart';

Future<void> main() async {
  if (Platform.isAndroid) {
    HttpOverrides.global = MyHttpOverrides();
  }
  await _init();
  runApp(EasyLocalization(
      path: ApplicationConstants.LANGUAGE_ASSET_PATH,
      supportedLocales: LanguageManager.instance.supportedLocalesList,
      startLocale: LanguageManager.instance.startLocale(),
      child: const MyApp()));
}

Future<void> _init() async {
  INetworkChangeManager networkChange = NetworkChangeManager();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Hive.initFlutter();
  //await EasyLocalization.ensureInitialized();
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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey),
        ),
        // theme: ThemeManager.craeteTheme(AppThemeLight()),
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        localizationsDelegates: context.localizationDelegates,
        builder: MainBuild.build,

        onGenerateRoute: NavigationRoute.instance.generateRoute,
        navigatorKey: NavigationService.instance.navigatorKey,
        //initialRoute: NavigationRoute.instance.initialRoute(),
        initialRoute: NavigationConstants.SPLASH,
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
