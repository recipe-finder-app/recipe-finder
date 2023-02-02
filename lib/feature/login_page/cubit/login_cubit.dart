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
  late TextEditingController emailController;
  late TextEditingController passwordController;
  ILoginService? service;

  LoginCubit() : super(LoginInit());

  @override
  void init() {
    loginFormKey = GlobalKey<FormState>();
    createAccountFormKey = GlobalKey<FormState>();
    forgotPasswordFormKey = GlobalKey<FormState>();
    userNameController = TextEditingController();
    emailController = TextEditingController();
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
    try {
      if (loginFormKey.currentState!.validate()) {
        final response = await service!.login(userNameController.text, passwordController.text);
        if (response!.data?.success != null) {
          if (response!.data!.success == true) {
            print(response.data!.token);
          } else if (response.data!.success == false) {
            print('kullanıcı adı veya şifre yanlış');
          }
        } else if (response.error!.description != null) {
          print('response.error!.description ${response.error!.description}');
        }
      }
      userNameController.clear();
      passwordController.clear();
    } catch (e) {
      print(e);
    }
  }

  void register() async {
    try {
      if (createAccountFormKey.currentState!.validate()) {
        final response = await service!.register(userNameController.text, emailController.text, passwordController.text);
        if (response!.data?.data != null) {
          if (response!.data!.data != null) {
            print(response.data!.token);
          } else if (response.data!.success == false) {
            print(response.data?.message);
          }
        } else if (response.error!.description != null) {
          print('response.error!.description ${response.error!.description}');
        }
      }
      userNameController.clear();
      emailController.clear();
      passwordController.clear();
    } catch (e) {
      print(e);
    }
  }

  void createAccount() {
    if (createAccountFormKey.currentState!.validate()) {}
  }

  void forgotPassword() {
    if (forgotPasswordFormKey.currentState!.validate()) {}
  }
}
