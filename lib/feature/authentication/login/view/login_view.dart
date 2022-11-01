import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_finder/core/component/widget/modal_bottom_sheet/circular_modal_bottom_sheet.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/component/widget/button/authenticate_circular_button.dart';
import '../../../../core/component/widget/button/login_button.dart';
import '../../../../core/component/widget/text/bold_text.dart';
import '../../../../core/constant/design/color_constant.dart';
import '../../../../product/component/widget/text_field/email_text_formfield.dart';
import '../../../../product/component/widget/text_field/password_text_formfield.dart';
import '../../../../product/component/widget/text_field/user_text_formfield.dart';
import '../cubit/login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  final String createAccountText = 'Create New Account';
  final String loginText = 'Login';
  final String laterText = 'Later';
  final String recipeText = 'Recipes for your have home ingredients';
  final String userNameText = 'Username';
  final String emailText = 'Email';
  final String emailAddressText = 'Email Address';
  final String sendEmailText = 'Send Email';
  final String passwordText = 'Password';
  final String forgotPasswordText = 'Forgot password?';
  final String orContinueWith = 'or continue with';
  final String loginGoogleText = 'Login with Google';
  final String loginFacebookText = 'Login with Facebook';
  final String registerGoogleText = 'Register with Google';
  final String registerFacebookText = 'Register with Facebook';
  final String dontHaveAccountText = 'Dont have any account?';
  final String alreadyHaveAccountText = 'Already have any account?';
  final String signUpText = 'Sign Up';
  final String signInText = 'Sign In';
  final String loremText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ';

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginCubit>(
      init: (cubitRead) {
        cubitRead.init();
      },
      onPageBuilder: (BuildContext context, cubitRead, cubitWatch) => Scaffold(
        backgroundColor: ColorConstants.instance.russianViolet,
        body: SafeArea(
          child: Padding(
            padding: context.paddingLowEdges,
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      child: Text(
                        laterText,
                        style: TextStyle(
                            color: ColorConstants.instance.oriolesOrange,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: SvgPicture.asset(
                    ImagePath.group5357.path,
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(recipeText,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24)),
                      LoginButton(
                        text: loginText,
                        onPressed: () {
                          signInBottomSheet(context);
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          signUpBottomSheet(context);
                        },
                        child: Text(createAccountText,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInBottomSheet(BuildContext context) {
    return CircularBottomSheet.instance.show(
      context,
      child: Column(
        children: [
          Flexible(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: BoldText(text: userNameText)),
                const UserTextFormField(),
                Align(
                    alignment: Alignment.centerLeft,
                    child: BoldText(text: passwordText)),
                const PasswordTextFormField(),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: BoldText(
                        text: forgotPasswordText,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        forgotPasswordBottomSheet(context);
                      },
                    )),
                LoginButton(text: loginText),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(orContinueWith),
                Column(
                  children: [
                    AuthenticateCircularButton(
                      borderColor: Colors.black,
                      textColor: Colors.black,
                      text: loginGoogleText,
                    ),
                    context.lowSizedBox,
                    AuthenticateCircularButton(
                      borderColor: Colors.black,
                      textColor: ColorConstants.instance.brightNavyBlue,
                      text: loginFacebookText,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BoldText(text: dontHaveAccountText),
                    TextButton(
                      child: Text(signUpText,
                          style: TextStyle(
                            color: ColorConstants.instance.oriolesOrange,
                          )),
                      onPressed: () {
                        Navigator.pop(context);
                        signUpBottomSheet(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> signUpBottomSheet(BuildContext context) {
    return CircularBottomSheet.instance.show(
      context,
      bottomSheetHeight: CircularBottomSheetHeight.high,
      child: Column(
        children: [
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: BoldText(text: userNameText)),
                const UserTextFormField(),
                Align(
                    alignment: Alignment.centerLeft,
                    child: BoldText(text: emailText)),
                const EmailTextFormField(),
                Align(
                    alignment: Alignment.centerLeft,
                    child: BoldText(text: passwordText)),
                const PasswordTextFormField(),
                LoginButton(text: createAccountText),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(orContinueWith),
                Column(
                  children: [
                    AuthenticateCircularButton(
                      borderColor: Colors.black,
                      textColor: Colors.black,
                      text: registerGoogleText,
                    ),
                    context.lowSizedBox,
                    AuthenticateCircularButton(
                      borderColor: Colors.black,
                      textColor: ColorConstants.instance.brightNavyBlue,
                      text: registerFacebookText,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BoldText(text: alreadyHaveAccountText),
                    TextButton(
                      child: Text(signInText,
                          style: TextStyle(
                            color: ColorConstants.instance.oriolesOrange,
                          )),
                      onPressed: () {
                        Navigator.pop(context);
                        signInBottomSheet(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> forgotPasswordBottomSheet(
    BuildContext context,
  ) {
    return CircularBottomSheet.instance.show(
      context,
      bottomSheetHeight: CircularBottomSheetHeight.short,
      resizeToAvoidBottomInset: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: BoldText(
                    text: forgotPasswordText,
                    fontSize: 20,
                  )),
              context.lowSizedBox,
              Text(
                loremText,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: BoldText(text: emailAddressText)),
              context.lowSizedBox,
              const EmailTextFormField(),
            ],
          ),
          context.veryLowSizedBox,
          LoginButton(text: sendEmailText),
        ],
      ),
    );
  }
}
