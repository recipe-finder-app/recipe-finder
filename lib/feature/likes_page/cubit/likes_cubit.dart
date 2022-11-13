import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/model/base_view_model.dart';
import '../service/likes_service.dart';
import 'likes_state.dart';

class LikesCubit extends Cubit<ILikesState> implements IBaseViewModel {
  late GlobalKey<FormState> loginFormKey;
  late GlobalKey<FormState> createAccountFormKey;
  late GlobalKey<FormState> forgotPasswordFormKey;
  ILikesService? service;

  LikesCubit() : super(LikesInit());

  @override
  void init() {
    loginFormKey = GlobalKey<FormState>();
    createAccountFormKey = GlobalKey<FormState>();
    forgotPasswordFormKey = GlobalKey<FormState>();

    service = LikesService();
  }

  @override
  BuildContext? context;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void dispose() {
    // TODO: implement dispose
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
