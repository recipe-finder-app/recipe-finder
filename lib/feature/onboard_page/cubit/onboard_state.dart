abstract class IOnboardState {
  IOnboardState();
}

class OnboardInit extends IOnboardState {
  OnboardInit();
}

class OnCompleting extends IOnboardState {
  late bool isLoading;
  OnCompleting(isLoading);
}

class ChangeCurrentIndex extends IOnboardState {
  late int index;
  ChangeCurrentIndex(index);
}

class OnboardError extends IOnboardState {
  String errorMessage;
  OnboardError(this.errorMessage);
}
