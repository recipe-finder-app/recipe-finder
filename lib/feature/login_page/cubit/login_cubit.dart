import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/model/base_view_model.dart';
import '../service/login_service.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<ILoginState> implements IBaseViewModel {
  late GlobalKey<FormState> loginFormKey;
  late GlobalKey<FormState> createAccountFormKey;
  late GlobalKey<FormState> forgotPasswordFormKey;
  late TextEditingController userNameController;
  late TextEditingController passwordController;
  ILoginService? service;

  LoginCubit() : super(LoginInit());

  @override
  void init() {
    loginFormKey = GlobalKey<FormState>();
    createAccountFormKey = GlobalKey<FormState>();
    forgotPasswordFormKey = GlobalKey<FormState>();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    service = LoginService();
  }

  @override
  BuildContext? context;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void dispose() {}

  void login() async {
    if (loginFormKey.currentState!.validate()) {
      final response = await service!.login(userNameController.text, passwordController.text);
      print(response.data?.success);
      if (response!.data?.success != null) {
        if (response!.data!.success == true) {
          print(response.data!.token);
        } else if (response.data!.success == false) {
          print('kullanıcı adı veya şifre yanlış');
        }
      } else if (response.error!.description != null) {
        print('${response.error!.description}');
      }
    }
  }

  void createAccount() {
    if (createAccountFormKey.currentState!.validate()) {}
  }

  void forgotPassword() {
    if (forgotPasswordFormKey.currentState!.validate()) {}
  }
}
