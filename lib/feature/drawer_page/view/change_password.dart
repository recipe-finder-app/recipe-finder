import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/product/widget/text_field/password_text_formfield.dart';

import '../../../product/widget/button/future_button.dart';

class DrawerChangePasswordView extends StatelessWidget {
  const DrawerChangePasswordView({super.key});

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
              'Change Password',
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
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Current Password'),
              context.normalSizedBox,
              PasswordTextFormField(
                controller: TextEditingController(),
              ),
            ]),
            context.normalSizedBox,
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('New Password'),
              context.normalSizedBox,
              PasswordTextFormField(
                controller: TextEditingController(),
              ),
            ]),
            context.normalSizedBox,
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Confirm New Password'),
              context.normalSizedBox,
              PasswordTextFormField(
                controller: TextEditingController(),
              ),
            ]),
            context.mediumSizedBox,
            FutureButton(
              text: 'Save',
              color: ColorConstants.instance.oriolesOrange,
            ),
          ]),
        ),
      ),
    );
  }
}
