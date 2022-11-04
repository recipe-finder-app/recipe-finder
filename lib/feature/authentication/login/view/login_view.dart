import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recipe_finder/core/component/widget/modal_bottom_sheet/circular_modal_bottom_sheet.dart';
import 'package:recipe_finder/core/component/widget/pop_up_menu_button/language_popup_menu_button.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/constant/navigation/navigation_constants.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/core/init/navigation/navigation_service.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/component/widget/button/authenticate_circular_button.dart';
import '../../../../core/component/widget/button/login_button.dart';
import '../../../../core/component/widget/svg_picture/image_svg.dart';
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
                      onPressed: () {
                        NavigationService.instance.navigateToPage(
                            path: NavigationConstants.NAV_CONTROLLER);
                      },
                    ),
                  ],
                ),
                Flexible(
                  flex: 5,
                  child: ImageSvg(
                    path: ImagePath.group5357.path,
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
                          signInBottomSheet(context, cubitRead);
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          signUpBottomSheet(context, cubitRead);
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

  Future<void> signInBottomSheet(
    BuildContext context,
    LoginCubit cubitRead,
  ) {
    return CircularBottomSheet.instance.show(
      context,
      child: Form(
        key: cubitRead.loginFormKey,
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
                          forgotPasswordBottomSheet(context, cubitRead);
                        },
                      )),
                  LoginButton(
                    text: LocaleKeys.login.locale,
                    onPressed: () {
                      cubitRead.login();
                    },
                  ),
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
                          signUpBottomSheet(context, cubitRead);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signUpBottomSheet(
    BuildContext context,
    LoginCubit cubitRead,
  ) {
    return CircularBottomSheet.instance.show(
      context,
      bottomSheetHeight: CircularBottomSheetHeight.high,
      child: Form(
        key: cubitRead.createAccountFormKey,
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
                  EmailTextFormField(
                    validator: true,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: LocaleBoldText(text: LocaleKeys.password.locale)),
                  PasswordTextFormField(),
                  LoginButton(
                    text: LocaleKeys.createNewAccount.locale,
                    onPressed: () {
                      cubitRead.createAccount();
                    },
                  ),
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
                          signInBottomSheet(context, cubitRead);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> forgotPasswordBottomSheet(
    BuildContext context,
    LoginCubit cubitRead,
  ) {
    return CircularBottomSheet.instance.show(
      context,
      bottomSheetHeight: CircularBottomSheetHeight.short,
      resizeToAvoidBottomInset: true,
      child: Form(
        key: cubitRead.forgotPasswordFormKey,
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
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: LocaleBoldText(
                      text: LocaleKeys.emailAddress.locale,
                    )),
                context.lowSizedBox,
                const EmailTextFormField(
                  validator: true,
                ),
              ],
            ),
            context.veryLowSizedBox,
            LoginButton(
              text: LocaleKeys.sendEmail.locale,
              onPressed: () {
                cubitRead.forgotPassword();
              },
            ),
          ],
        ),
      ),
    );
  }
}
