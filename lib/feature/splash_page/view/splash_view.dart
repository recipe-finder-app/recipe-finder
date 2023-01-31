import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_finder/core/base/view/base_view.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/feature/splash_page/cubit/splash_cubit.dart';
import 'package:recipe_finder/product/widget_core/text/bold_text.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SplashCubit>(
      init: (cubitRead) {
        cubitRead.init();
      },
      onPageBuilder: (context, cubitRead, watch) => Scaffold(
        backgroundColor: ColorConstants.instance.oriolesOrange,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(ImagePath.splashAnimation.path, height: 275, width: 150),
            context.normalSizedBox,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BoldText(
                  text: 'Recipe',
                  textColor: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                Text(
                  'Finder',
                  style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white, fontSize: 24),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
