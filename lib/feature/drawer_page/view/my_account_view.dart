import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/product/widget/alert_dialog/question_alert_dialog.dart';
import 'package:recipe_finder/product/widget/button/drawer_button.dart';

import '../../../product/utils/constant/navigation_constants.dart';
import '../../../core/init/navigation/navigation_service.dart';

class DrawerMyAccountView extends StatelessWidget {
  const DrawerMyAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.instance.russianViolet,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstants.instance.russianViolet,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: ColorConstants.instance.white)),
            Text(
              'My Account',
              style: TextStyle(color: ColorConstants.instance.white),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Container(
          height: context.screenHeight,
          width: context.screenWidth,
          decoration: BoxDecoration(
            color: ColorConstants.instance.white,
            borderRadius: context.radiusTopCircularHigh,
          ),
          child: Column(children: [
            context.mediumSizedBox,
            RecipeDrawerButton(
              text: 'Change Username',
              textColor: ColorConstants.instance.russianViolet,
              onPressed: () {
                NavigationService.instance.navigateToPage(path: NavigationConstant.CHANGEUSERNAME);
              },
              color: ColorConstants.instance.white,
            ),
            context.normalSizedBox,
            RecipeDrawerButton(
              text: 'Change Password',
              textColor: ColorConstants.instance.russianViolet,
              onPressed: () {
                NavigationService.instance.navigateToPage(path: NavigationConstant.CHANGEPASSWORD);
              },
              color: ColorConstants.instance.white,
            ),
            context.normalSizedBox,
            RecipeDrawerButton(
              text: 'Delete Account',
              textColor: ColorConstants.instance.oriolesOrange,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return QuestionAlertDialog(
                        explanation: 'Are you sure you want to delete your account ?',
                        onPressedYes: () {},
                      );
                    });
              },
              color: ColorConstants.instance.white,
            ),
          ]),
        ),
      ),
    );
  }
}
