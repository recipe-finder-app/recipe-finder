import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/model/base_view_model.dart';
import '../service/login_service.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<ILoginState> implements IBaseViewModel {
  late GlobalKey<FormState> loginFormKey;
  late GlobalKey<FormState> createAccountFormKey;
  late GlobalKey<FormState> forgotPasswordFormKey;
  ILoginService? service;

  LoginCubit() : super(LoginInit());

  @override
  void init() {
    loginFormKey = GlobalKey<FormState>();
    createAccountFormKey = GlobalKey<FormState>();
    forgotPasswordFormKey = GlobalKey<FormState>();

    service = LoginService();
    print('login init tamam');
  }

  @override
  BuildContext? context;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void dispose() {
    print('login dispose tamam');
  }

  void login() {
    if (loginFormKey.currentState!.validate()) {}
  }

  void createAccount() {
    if (createAccountFormKey.currentState!.validate()) {}
  }

  void forgotPassword() {
    if (forgotPasswordFormKey.currentState!.validate()) {}
  }
}
