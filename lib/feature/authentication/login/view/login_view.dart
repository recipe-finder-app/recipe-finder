import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_finder/core/component/widget/modal_bottom_sheet/circular_modal_bottom_sheet.dart';
import 'package:recipe_finder/core/component/widget/pop_up_menu_button/language_popup_menu_button.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/component/widget/button/authenticate_circular_button.dart';
import '../../../../core/component/widget/button/login_button.dart';
import '../../../../core/component/widget/text/locale_bold_text.dart';
import '../../../../core/component/widget/text/locale_text.dart';
import '../../../../core/constant/design/color_constant.dart';
import '../../../../core/init/language/locale_keys.g.dart';
import '../../../../product/component/widget/text_field/email_text_formfield.dart';
import '../../../../product/component/widget/text_field/password_text_formfield.dart';
import '../../../../product/component/widget/text_field/user_text_formfield.dart';
import '../cubit/login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const LanguagePopupMenuButton(),
                    TextButton(
                      child: LocaleText(
                        text: LocaleKeys.later,
                        style: TextStyle(
                            color: ColorConstants.instance.oriolesOrange,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      onPressed: () {},
                    ),
                  ],
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
                      LocaleText(
                          text: LocaleKeys.recipeIngredients,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24)),
                      LoginButton(
                        text: LocaleKeys.login.locale,
                        onPressed: () {
                          signInBottomSheet(context);
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          signUpBottomSheet(context);
                        },
                        child: LocaleText(
                            text: LocaleKeys.createNewAccount,
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
                const Align(
                    alignment: Alignment.centerLeft,
                    child: LocaleBoldText(text: LocaleKeys.userName)),
                const UserTextFormField(),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: LocaleBoldText(text: LocaleKeys.password)),
                const PasswordTextFormField(),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: const LocaleBoldText(
                        text: LocaleKeys.forgotPassword,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        forgotPasswordBottomSheet(context);
                      },
                    )),
                const LoginButton(text: LocaleKeys.login),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const LocaleText(
                  text: LocaleKeys.orContinueWith,
                ),
                Column(
                  children: [
                    AuthenticateCircularButton(
                      borderColor: Colors.black,
                      textColor: Colors.black,
                      text: LocaleKeys.loginWithGoogle.locale,
                    ),
                    context.lowSizedBox,
                    AuthenticateCircularButton(
                      borderColor: Colors.black,
                      textColor: ColorConstants.instance.brightNavyBlue,
                      text: LocaleKeys.loginWithFacebook.locale,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LocaleBoldText(text: LocaleKeys.dontHaveAnyAccount),
                    TextButton(
                      child: LocaleText(
                          text: LocaleKeys.signUp,
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
                    child: LocaleBoldText(text: LocaleKeys.userName.locale)),
                UserTextFormField(),
                Align(
                    alignment: Alignment.centerLeft,
                    child: LocaleBoldText(text: LocaleKeys.email.locale)),
                EmailTextFormField(),
                Align(
                    alignment: Alignment.centerLeft,
                    child: LocaleBoldText(text: LocaleKeys.password.locale)),
                PasswordTextFormField(),
                LoginButton(text: LocaleKeys.createNewAccount.locale),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LocaleText(text: LocaleKeys.orContinueWith.locale),
                Column(
                  children: [
                    AuthenticateCircularButton(
                      borderColor: Colors.black,
                      textColor: Colors.black,
                      text: LocaleKeys.registerWithGoogle.locale,
                    ),
                    context.lowSizedBox,
                    AuthenticateCircularButton(
                      borderColor: Colors.black,
                      textColor: ColorConstants.instance.brightNavyBlue,
                      text: LocaleKeys.registerWithFacebook.locale,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LocaleBoldText(
                        text: LocaleKeys.alreadyHaveAnyAccount.locale),
                    TextButton(
                      child: LocaleText(
                          text: LocaleKeys.signIn.locale,
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
                  child: LocaleBoldText(
                    text: LocaleKeys.forgotPassword.locale,
                    fontSize: 20,
                  )),
              context.lowSizedBox,
              Text(
                'loremText',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: LocaleBoldText(text: LocaleKeys.emailAddress.locale)),
              context.lowSizedBox,
              const EmailTextFormField(),
            ],
          ),
          context.veryLowSizedBox,
          LoginButton(text: LocaleKeys.sendEmail.locale),
        ],
      ),
    );
  }
}
