import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../../core/init/cache/hive_manager.dart';
import '../../../product/utils/enum/hive_enum.dart';
import '../model/onboard_model.dart';
import '../service/onboard_service.dart';
import 'onboard_state.dart';

class OnboardCubit extends Cubit<IOnboardState> implements IBaseViewModel {
  bool completing = false;
  int currentIndex = 0;
  final List<OnboardModel> onboardItems = OnboardItems().items;
  @override
  BuildContext? context;
  @override
  void setContext(BuildContext context) => this.context = context;

  

  IOnboardService? service;
  OnboardCubit() : super(OnboardInit());
  @override
  Future<void> init() async {
    service = OnboardService();
   await setFirstOpening();
    clear();
    print('onboard init çalıştı');
  }

  void onCompleting() {
    completing = !completing;
    emit(OnCompleting(completing));
  }

  Future<void> onComplete() async {
    try {
      onCompleting();
    } catch (e) {
    } finally {
      onCompleting();
    }
  }

  void changeCurrentIndex(int value) {
    if (value >= 0 && value < onboardItems.length) {
      currentIndex = value;
      emit(ChangeCurrentIndex(currentIndex));
     
    }
  }
 Future<void> setFirstOpening() async {
     IHiveManager<bool> hiveManager = HiveManager<bool>(HiveBoxEnum.firstOpening);
     if(await hiveManager.get(HiveKeyEnum.firstOpening)==true){
     await hiveManager.put(HiveKeyEnum.firstOpening, false);
     }
  }
  void clear() {
    completing = false;
    currentIndex = 0;
  }

  @override
  void dispose() {
    clear();
    print('onboard dispose tamam');
  }
}
