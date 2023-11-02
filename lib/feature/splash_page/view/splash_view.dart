import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_finder/core/base/view/base_view.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/product/utils/constant/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/feature/splash_page/cubit/splash_cubit.dart';

import '../../../core/widget/text/bold_text.dart';

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
        body: SizedBox(
          height: context.screenHeight,
          width: context.screenWidth,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(ImagePathConstant.splashAnimation.path, height: 275, width: 150),
                context.lowSizedBox,
               const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    BoldText(
                      text: 'Tarifi',
                      textColor: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                    Text(
                      'Bul',
                      style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
