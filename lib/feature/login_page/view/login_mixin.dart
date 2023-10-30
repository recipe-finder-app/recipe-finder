import 'package:flutter/material.dart';
import 'package:recipe_finder/feature/login_page/view/login_view.dart';

mixin LoginMixin{
   final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> createAccountFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> createTokenFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> tokenVerificationFormKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
}