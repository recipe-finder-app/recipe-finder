import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/model/base_view_model.dart';
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

  PageController pageController = PageController(initialPage: 0);

  IOnboardService? service;
  OnboardCubit() : super(OnboardInit());
  @override
  void init() {
    service = OnboardService();
    clear();
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
      pageController.animateToPage(
        value,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.linear,
      );
      emit(ChangeCurrentIndex(currentIndex));
    }
  }

  void clear() {
    completing = false;
    currentIndex = 0;
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
