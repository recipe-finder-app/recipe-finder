import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../service/login_service.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<ILoginState> implements IBaseViewModel {
  late GlobalKey<FormState> formKey;
  ILoginService? service;

  LoginCubit() : super(LoginInit());

  @override
  void init() {
    formKey = GlobalKey<FormState>();

    service = LoginService();
  }

  @override
  BuildContext? context;
  @override
  void setContext(BuildContext context) => this.context = context;
  @override
  void dispose() {
    // TODO: implement dispose
  }
}
