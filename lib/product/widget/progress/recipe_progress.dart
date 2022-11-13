import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';

class RecipeProgress extends StatelessWidget {
  const RecipeProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
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
    );
  }
}
