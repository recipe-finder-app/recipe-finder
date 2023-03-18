import 'package:flutter_bloc/flutter_bloc.dart';

class BaseCubit extends Cubit<IBaseCubitState> {
  BaseCubit() : super(BaseInitState());
  bool isLoading = false;
  void changeLoadingState() {
    print("isLoading=$isLoading");
    isLoading = !isLoading;
    emit(ChangeIsLoadingState(isLoading));
    print("isLoading=$isLoading");
  }

  void setLoadingState(bool value) {
    isLoading = value;
    print("isLoading=$isLoading");
    emit(ChangeIsLoadingState(isLoading));
    print("isLoading=$isLoading");
  }

  void startLoading() {
    isLoading = true;
    emit(ChangeIsLoadingState(isLoading));
  }

  void stopLoading() {
    isLoading = false;
    emit(ChangeIsLoadingState(isLoading));
  }
}

abstract class IBaseCubitState {
  IBaseCubitState();
}

class BaseInitState extends IBaseCubitState {
  BaseInitState();
}

class ChangeIsLoadingState extends IBaseCubitState {
  late bool isLoading = false;
  ChangeIsLoadingState(this.isLoading);
}
