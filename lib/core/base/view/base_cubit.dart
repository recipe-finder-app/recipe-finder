import 'package:flutter_bloc/flutter_bloc.dart';

class BaseCubit extends Cubit<IBaseCubitState> {
  bool isLoading = false;
  void changeLoadingState() {
    print("isLoading=$isLoading");
    emit(ChangeIsLoadingState(isLoading));
    print("isLoading=$isLoading");
  }

  void setLoadingState(bool value) {
    isLoading = value;
    print("isLoading=$isLoading");
    emit(ChangeIsLoadingState(isLoading));
    print("isLoading=$isLoading");
  }

  BaseCubit() : super(BaseInitState());
}

abstract class IBaseCubitState {
  IBaseCubitState();
}

class BaseInitState extends IBaseCubitState {
  BaseInitState();
}

class ChangeIsLoadingState extends IBaseCubitState {
  final bool isLoading;
  ChangeIsLoadingState(this.isLoading);
}
