abstract class IHomeState {
  IHomeState();
}

class HomeInit extends IHomeState {
  HomeInit();
}

class OnHomeLoading extends IHomeState {
  late bool isLoading;
  OnHomeLoading(isLoading);
}

class HomeError extends IHomeState {
  String errorMessage;
  HomeError(this.errorMessage);
}
