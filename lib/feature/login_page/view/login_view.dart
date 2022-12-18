import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/product/component/modal_bottom_sheet/circular_modal_bottom_sheet.dart';
import 'package:recipe_finder/product/component/pop_up_menu_button/language_popup_menu_button.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/constant/design/color_constant.dart';
import '../../../core/constant/navigation/navigation_constants.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../../../product/component/image_format/image_svg.dart';
import '../../../product/component/text/locale_bold_text.dart';
import '../../../product/component/text/locale_text.dart';
import '../../../product/widget/button/login_button.dart';
import '../../../product/widget/button/recipe_circular_button.dart';
import '../../../product/widget/text_field/email_text_formfield.dart';
import '../../../product/widget/text_field/password_text_formfield.dart';
import '../../../product/widget/text_field/user_text_formfield.dart';
import '../cubit/login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginCubit>(
      init: (cubitRead) {
        cubitRead.init();
      },
      dispose: (cubitRead) => cubitRead.dispose(),
      visibleProgress: false,
      onPageBuilder: (BuildContext context, cubitRead, cubitWatch) => Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
            colors: [
              const Color(0xFF034A72),
              ColorConstants.instance.russianViolet,
            ],
            center: const Alignment(0.0, -0.3),
            focal: const Alignment(0.2, -0.2),
            focalRadius: 0.0,
          )),
          child: SafeArea(
            child: Padding(
              padding: context.paddingNormalAll,
              child: Column(
                children: [
                  Padding(
                    padding: context.paddingLowEdges,
                    child: Row(
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
                              path: NavigationConstants.MATERIALSEARCH,
                            );

                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) {
                            //   return MaterialSearch2View();
                            // }));
                          },
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: ImageSvg(
                      path: ImagePath.group5357.path,
                    ),
                  ),
                  Flexible(
                    flex: 4,
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
                          text: LocaleKeys.login,
                          onPressed: () {
                            signInBottomSheet(context, cubitRead);
                          },
                          color: ColorConstants.instance.oriolesOrange,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: LocaleBoldText(text: LocaleKeys.userName)),
                    context.lowSizedBox,
                    const UserTextFormField(),
                  ]),
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: LocaleBoldText(text: LocaleKeys.password)),
                    context.lowSizedBox,
                    const PasswordTextFormField(),
                  ]),
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
                    color: ColorConstants.instance.oriolesOrange,
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
                      RecipeCircularButton(
                        borderColor: Colors.black,
                        textColor: Colors.black,
                        text: LocaleKeys.loginWithGoogle.locale,
                      ),
                      context.lowSizedBox,
                      RecipeCircularButton(
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
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child:
                              LocaleBoldText(text: LocaleKeys.userName.locale)),
                      context.lowSizedBox,
                      const UserTextFormField(),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: LocaleBoldText(text: LocaleKeys.email.locale)),
                      context.lowSizedBox,
                      const EmailTextFormField(
                        validator: true,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child:
                              LocaleBoldText(text: LocaleKeys.password.locale)),
                      context.lowSizedBox,
                      const PasswordTextFormField(),
                    ],
                  ),
                  LoginButton(
                    text: LocaleKeys.createNewAccount.locale,
                    onPressed: () {
                      cubitRead.createAccount();
                    },
                    color: ColorConstants.instance.oriolesOrange,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LocaleText(text: LocaleKeys.orContinueWith.locale),
                  Column(
                    children: [
                      RecipeCircularButton(
                        borderColor: Colors.black,
                        textColor: Colors.black,
                        text: LocaleKeys.registerWithGoogle.locale,
                      ),
                      context.lowSizedBox,
                      RecipeCircularButton(
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
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  style: TextStyle(color: Colors.grey),
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
            context.lowSizedBox,
            LoginButton(
              text: LocaleKeys.sendEmail.locale,
              onPressed: () {
                cubitRead.forgotPassword();
              },
              color: ColorConstants.instance.oriolesOrange,
            ),
          ],
        ),
      ),
    );
  }
}
