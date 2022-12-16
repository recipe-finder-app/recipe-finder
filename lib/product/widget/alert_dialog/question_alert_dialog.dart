import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/product/component/text/locale_text.dart';
import 'package:recipe_finder/product/widget/button/recipe_circular_button.dart';

import '../../../core/init/language/locale_keys.g.dart';

class QuestionAlertDialog extends StatelessWidget {
  final String explanation;
  final VoidCallback? onPressedYes;
  const QuestionAlertDialog(
      {Key? key, this.onPressedYes, required this.explanation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: context.radiusAllCircularMedium,
      ),
      title: Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.close,
              color: Colors.grey,
              size: 36,
            ),
          )),
      content: LocaleText(
        fontSize: 14,
        text: explanation,
        maxLines: 3,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RecipeCircularButton(
              width: context.screenWidth / 4,
              text: LocaleKeys.no,
              textColor: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              color: ColorConstants.instance.brightGraySolid2,
            ),
            RecipeCircularButton(
              width: context.screenWidth / 4,
              text: LocaleKeys.yes,
              onPressed: () {
                if (onPressedYes != null) {
                  onPressedYes!();
                }
                Navigator.pop(context);
              },
              color: ColorConstants.instance.russianViolet,
            ),
          ],
        ),
        context.lowSizedBox,
      ],
    );
  }
}
