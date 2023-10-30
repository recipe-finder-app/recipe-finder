import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:recipe_finder/core/init/navigation/navigation_route.dart';
import 'package:recipe_finder/core/init/navigation/navigation_service.dart';

import 'core/constant/app/app_constants.dart';
import 'core/constant/enum/network_result_enum.dart';
import 'product/utils/constant/navigation_constant.dart';
import 'core/init/language/language_manager.dart';
import 'core/init/main_build/main_build.dart';
import 'core/init/network/connection_activity/network_change_manager.dart';
import 'core/init/notifier/bloc_list.dart';
import 'core/widget/alert_dialog/alert_dialog_no_connection.dart';
import 'feature/onboard_page/view/onboard_view.dart';

Future<void> main() async {
  if (Platform.isAndroid) {
    HttpOverrides.global = MyHttpOverrides();
  }
  await _init();
  runApp(EasyLocalization(path: ApplicationConstants.LANGUAGE_ASSET_PATH, supportedLocales: LanguageManager.instance.supportedLocalesList, startLocale: LanguageManager.instance.startLocale(), child: const MyApp()));
}

Future<void> _init() async {
  INetworkChangeManager networkChange = NetworkChangeManager();
 WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //await EasyLocalization.ensureInitialized();
  final result = await networkChange.checkNetworkInitial();

  if (result == NetworkResult.off) {
    NoNetworkAlertDialog();
  } else {
    WidgetsFlutterBinding.ensureInitialized();
  }
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...ApplicationBloc.instance.dependItems],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //home:OnboardView(),
        theme: ThemeData(
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: Colors.white,
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
        initialRoute: NavigationConstant.SPLASH,
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
