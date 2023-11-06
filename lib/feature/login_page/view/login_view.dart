
import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/enum/device_size_enum.dart';
import 'package:recipe_finder/feature/login_page/view/login_mixin.dart';
import 'package:recipe_finder/product/utils/constant/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/product/model/social_adapter.dart';
import 'package:recipe_finder/product/widget/button/recipe_circular_button.dart';
import 'package:recipe_finder/product/widget/button/social_button.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/constant/design/color_constant.dart';
import '../../../product/utils/constant/navigation_constant.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../../../core/widget/alert_dialog/alert_dialog_error.dart';
import '../../../core/widget/alert_dialog/alert_dialog_success.dart';
import '../../../core/widget/image_format/image_svg.dart';
import '../../../core/widget/modal_bottom_sheet/circular_modal_bottom_sheet.dart';
import '../../../core/widget/pop_up_menu_button/language_popup_menu_button.dart';
import '../../../core/widget/text/locale_bold_text.dart';
import '../../../core/widget/text/locale_text.dart';
import '../../../product/widget/button/future_button.dart';
import '../../../product/widget/text_field/email_text_formfield.dart';
import '../../../product/widget/text_field/password_text_formfield.dart';
import '../../../product/widget/text_field/user_text_formfield.dart';
import '../cubit/login_cubit.dart';

class LoginView extends StatelessWidget with LoginMixin {
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginCubit>(
      init: (cubitRead) async {
        cubitRead.init();
      },
      dispose: (cubitRead) => cubitRead.dispose(),
      onPageBuilder: (BuildContext context, cubitRead, cubitWatch) => Scaffold(
        body: WillPopScope(
          onWillPop: () => Future<bool>.value(false),
          child: Container(
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
                    languageAndLaterRow(context),
                    buildImage(context),
                    buildUnderColumn(context, cubitRead),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Flexible buildUnderColumn(BuildContext context, LoginCubit cubitRead) {
    return Flexible(
      flex: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          LocaleText(
              text: LocaleKeys.recipeIngredients,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24)),
          RecipeCircularButton(
            text: const LocaleText(
              text: LocaleKeys.login,
              color: Colors.white,
            ),
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
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Flexible buildImage(BuildContext context) {
    return Flexible(
      flex: context.screenHeight < DeviceSizeEnum.inch_5.size ? 8 : 5,
      child: ImageSvg(
        path: ImagePathConstant.group5357.path,
      ),
    );
  }

  Padding languageAndLaterRow(BuildContext context) {
    return Padding(
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
                path: NavigationConstant.MATERIALSEARCH,
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> signInBottomSheet(
    BuildContext context,
    LoginCubit cubitRead,
  ) {
    return CircularBottomSheet.instance.show(
      context,
      bottomSheetHeight: context.screenHeightIsLessThan5Inch
          ? CircularBottomSheetHeight.high
          : CircularBottomSheetHeight.standard,
      child: Form(
        key: loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    const Align(
                        alignment: Alignment.centerLeft,
                        child:
                            LocaleBoldText(text: LocaleKeys.userNameOrEmail)),
                    context.lowSizedBox,
                    UserTextFormField(
                      controller: userNameController,
                      canBeEmpty: false,
                    ),
                  ]),
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: LocaleBoldText(text: LocaleKeys.password)),
                    context.lowSizedBox,
                    PasswordTextFormField(
                      controller: passwordController,
                      canBeEmpty: false,
                    ),
                    context.lowSizedBox,
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
                    context.lowSizedBox,
                    FutureButton(
                          text: LocaleKeys.login.locale,
                          onPressed: () async {
                            if (loginFormKey.currentState!.validate()) {
                              await cubitRead
                                  .signIn(userNameController.text.trim(),
                                      passwordController.text.trim())
                                  .then((responseModel) {
                                     if (responseModel.success == false) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialogError(
                      text: responseModel.error?.message ?? '',
                    );
                  });
            } else if (responseModel.success == true) {
             NavigationService.instance.navigateToPage(path:NavigationConstant.NAV_CONTROLLER);
            }
                                  });
                            }
                          },
                          color: ColorConstants.instance.oriolesOrange,
                        ),
                  ]),
                ],
              ),
            ),
            Flexible(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const LocaleText(
                    text: LocaleKeys.orContinueWith,
                  ),
                  Column(
                    children: [
                      SocialButton(
                          adapter: GoogleAdapter(),
                          onCompleted: (user) {
                            if (user != null) {}
                          }),
                      context.lowSizedBox,
                      SocialButton(
                          adapter: FacebookAdapter(), onCompleted: (token) {}),
                      context.lowSizedBox,
                      SocialButton(
                          adapter: AppleAdapter(), onCompleted: (token) {}),
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
        key: createAccountFormKey,
        child: Column(
          children: [
            Flexible(
              flex: 7,
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
                      UserTextFormField(
                        controller: userNameController,
                        hintText: LocaleKeys.userName.locale,
                        canBeEmpty: false,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: LocaleBoldText(text: LocaleKeys.email.locale)),
                      context.lowSizedBox,
                      EmailTextFormField(
                        controller: emailController,
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
                      PasswordTextFormField(
                        controller: passwordController,
                        canBeEmpty: false,
                      ),
                    ],
                  ),
                  FutureButton(
                    text: LocaleKeys.createNewAccount.locale,
                    onPressed: () async {
                      if (createAccountFormKey.currentState!.validate()) {
                        await cubitRead.signUp(
                            userNameController.text.trim(),
                            emailController.text.trim(),
                            passwordController.text.trim());
                      }
                    },
                    color: ColorConstants.instance.oriolesOrange,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LocaleText(text: LocaleKeys.orContinueWith.locale),
                  Column(
                    children: [
                      SocialButton(
                          adapter: GoogleAdapter(), onCompleted: (token) {}),
                      context.lowSizedBox,
                      SocialButton(
                          adapter: FacebookAdapter(), onCompleted: (token) {}),
                      context.lowSizedBox,
                      SocialButton(
                          adapter: AppleAdapter(), onCompleted: (token) {}),
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
        key: createTokenFormKey,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            context.lowSizedBox,
            Flexible(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LocaleBoldText(
                    text: LocaleKeys.forgotPassword,
                    fontSize: 20,
                  ),
                  context.lowSizedBox,
                  const LocaleText(
                    text: LocaleKeys.resetEmailText,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LocaleBoldText(
                    text: LocaleKeys.emailAddress,
                  ),
                  context.lowSizedBox,
                  EmailTextFormField(
                    controller: emailController,
                    validator: true,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: FutureButton(
                text: LocaleKeys.sendEmail.locale,
                color: ColorConstants.instance.oriolesOrange,
                onPressed: () async {
                  /* final sendEmailResponse = await cubitRead.createToken();
                  if (sendEmailResponse == true) {
                    Navigator.pop(context);
                    verificationCodeBottomSheet(context, cubitRead, cubitRead.emailController.text);
                  } else if (sendEmailResponse == false) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialogError(text: LocaleKeys.anErrorOccured.locale);
                        });
                  }*/
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> verificationCodeBottomSheet(
    BuildContext context,
    LoginCubit cubitRead,
    String email,
  ) {
    return CircularBottomSheet.instance.show(
      context,
      bottomSheetHeight: CircularBottomSheetHeight.short,
      resizeToAvoidBottomInset: true,
      child: Form(
        key: tokenVerificationFormKey,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            context.lowSizedBox,
            Flexible(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LocaleBoldText(
                    text: LocaleKeys.verificationCode,
                    fontSize: 20,
                  ),
                  context.lowSizedBox,
                  const LocaleText(
                    text: LocaleKeys.enterEmailAdressVerificationCode,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LocaleBoldText(
                    text: LocaleKeys.verificationCode,
                  ),
                  context.lowSizedBox,
                  PasswordTextFormField(
                    controller: userNameController,
                    hintText: LocaleKeys.verificationCode.locale,
                    canBeEmpty: false,
                  ),
                  const LocaleBoldText(
                    text: LocaleKeys.password,
                  ),
                  context.lowSizedBox,
                  PasswordTextFormField(
                    controller: passwordController,
                    hintText: LocaleKeys.password.locale,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: FutureButton(
                text: LocaleKeys.verify,
                color: ColorConstants.instance.oriolesOrange,
                onPressed: () async {
                  /*  final response = await cubitRead.tokenVerification(email);
                  if (response?.success == true) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialogSuccess(text: LocaleKeys.emailChangeSuccessText.locale);
                        });
                    Navigator.pop(context);
                  } else if (response?.success == false) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialogError(text: response?.message ?? LocaleKeys.anErrorOccured.locale);
                        });
                  }*/
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
