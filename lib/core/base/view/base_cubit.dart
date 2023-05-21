/*class BaseCubit extends Cubit<IBaseCubitState> {
  BaseCubit() : super(BaseInitState());
  bool isLoading = false;
  void changeLoadingState() {
    isLoading = !isLoading;
    emit(ChangeIsLoadingState(isLoading));
  }

  void setLoadingState(bool value) {
    isLoading = value;
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
}*/
