import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:recipe_finder/core/base/model/base_view_model.dart';
import 'package:recipe_finder/product/model/user/user_model.dart';
import 'package:recipe_finder/product/utils/constant/navigation_constant.dart';
import 'package:recipe_finder/core/init/navigation/navigation_service.dart';
import 'package:recipe_finder/firebase_options.dart';

import '../../../core/init/cache/hive_manager.dart';
import '../../../product/utils/enum/hive_enum.dart';

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
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
   // Hive..init('HiveDatabase');
    await Hive.initFlutter();
    await Future.delayed(const Duration(milliseconds: 4000)).then((value) async {
     final bool? isFirstOpen = await isFirstOpening();
     final UserModel? user = await getUserInformation(); 
 if(isFirstOpen==true || isFirstOpen == null){
       NavigationService.instance.navigateToPageClear(path: NavigationConstant.ONBOARD);
    }
    else if(user!=null){
 NavigationService.instance.navigateToPageClear(path: NavigationConstant.NAV_CONTROLLER);
    }
    else {
 NavigationService.instance.navigateToPageClear(path: NavigationConstant.LOGIN);
    }
 
    });
  }
  Future<bool?> isFirstOpening() async {
     IHiveManager<bool> hiveManager = HiveManager<bool>(HiveBoxEnum.firstOpening);
     
 final isFirstOpening = await hiveManager.get(HiveKeyEnum.firstOpening);
  print("isFirstOpening $isFirstOpening");
 return isFirstOpening;
  }
  Future<UserModel?> getUserInformation() async {
     IHiveManager<UserModel> hiveManager = HiveManager<UserModel>(HiveBoxEnum.userModel);
 final user = await hiveManager.get(HiveKeyEnum.user);
 print(user?.email);
 return user;
  }
  @override
  void setContext(BuildContext context) {
    this.context = context;
  }
}
