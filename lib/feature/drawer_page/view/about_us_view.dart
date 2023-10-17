import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';

import '../../../product/widget/button/drawer_button.dart';

class DrawerAboutUsView extends StatelessWidget {
  const DrawerAboutUsView({super.key});

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
              'About Us',
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
              text: 'Terms of Service',
              textColor: ColorConstants.instance.russianViolet,
              onPressed: () {},
              color: ColorConstants.instance.white,
            ),
            context.normalSizedBox,
            RecipeDrawerButton(
              text: 'Privacy Policy',
              textColor: ColorConstants.instance.russianViolet,
              onPressed: () {},
              color: ColorConstants.instance.white,
            ),
            context.normalSizedBox,
            RecipeDrawerButton(
              text: 'Websitesi',
              textColor: ColorConstants.instance.russianViolet,
              onPressed: () {},
              color: ColorConstants.instance.white,
            ),
          ]),
        ),
      ),
    );
  }
}
