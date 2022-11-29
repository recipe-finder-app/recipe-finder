import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/component/text/locale_bold_text.dart';

class RecipeProgress extends StatelessWidget {
  final Widget? child;
  final bool? visible;
  const RecipeProgress({Key? key, this.child, this.visible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          child ?? const Center(),
          visible == true
              ? const ModalBarrier(
                  dismissible: false,
                )
              : const Center(),
          visible == true
              ? BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          SizedBox(
                            height: 140,
                            width: 140,
                            child: CircularProgressIndicator(
                              color: ColorConstants.instance.oriolesOrange,
                              backgroundColor: Colors.grey.withOpacity(0.2),
                            ),
                          ),
                          Lottie.asset(ImagePath.cookingAnimation.path,
                              height: 140, width: 140),
                        ],
                      ),
                      Padding(
                        padding: context.paddingHighEdges,
                        child: Padding(
                            padding: context.paddingMediumOnlyTop,
                            child: const LocaleBoldText(
                              text: LocaleKeys.progressText,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              textColor: Colors.white,
                              fontSize: 16,
                              style: TextStyle(
                                decoration: TextDecoration.none,
                              ),
                            )),
                      ),
                    ],
                  ),
                )
              : const Center(),
        ],
      ),
    );
  }
}
