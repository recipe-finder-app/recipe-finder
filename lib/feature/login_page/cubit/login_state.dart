import 'package:equatable/equatable.dart';
import 'package:recipe_finder/product/model/base_response_model.dart';

class LoginState extends Equatable {
 final BaseResponseModel? responseModel;
 final bool? isLoading;

   const LoginState({
    this.responseModel,
    this.isLoading
  });
  
  LoginState copyWith({
    BaseResponseModel? responseModel,
    bool? isLoading    
  }) {
    return LoginState(
          responseModel: responseModel ?? this.responseModel,
      isLoading: isLoading ?? this.isLoading
    );
  }

@override
List<Object?> get props => [responseModel, isLoading];
}
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
