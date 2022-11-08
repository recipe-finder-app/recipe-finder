abstract class ILoginState {
  ILoginState();
}

class LoginInit extends ILoginState {
  LoginInit();
}

class OnAuthenticateLoading extends ILoginState {
  late bool isLoading;
  OnAuthenticateLoading(isLoading);
}

class LoginError extends ILoginState {
  String errorMessage;
  LoginError(this.errorMessage);
}
