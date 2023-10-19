import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:recipe_finder/core/base/model/base_view_model.dart';
import 'package:recipe_finder/core/constant/navigation/navigation_constants.dart';
import 'package:recipe_finder/core/init/navigation/navigation_service.dart';
import 'package:recipe_finder/firebase_options.dart';

class SplashCubit extends Cubit<int> implements IBaseViewModel {
  SplashCubit() : super(0);

  @override
  BuildContext? context;

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<void> init() async {
    await EasyLocalization.ensureInitialized();
    Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
    Hive..init('HiveDatabase');
    await Hive.initFlutter();
    Future.delayed(const Duration(milliseconds: 4500)).then((value) => NavigationService.instance.navigateToPageClear(path: NavigationConstants.LOGIN));
  }

  @override
  void setContext(BuildContext context) {
    this.context = context;
  }
}
