import 'package:flutter/material.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/core/widget/text/locale_text.dart';
import 'package:recipe_finder/product/widget/button/recipe_circular_button.dart';

class AlertDialogError extends StatelessWidget {
  final String text;
  final Color? textColor;
  final String? fontFamily;
  final String? buttonText;
  final bool? locale = false;

  const AlertDialogError({Key? key, required this.text, this.buttonText, this.textColor, this.fontFamily}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.red.withOpacity(0.9),
      content: Text(
        text,
        style: TextStyle(color: textColor ?? Colors.white, fontFamily: fontFamily),
        textAlign: TextAlign.center,
      ),
      title: const Icon(
        Icons.error,
        color: Colors.white,
        size: 50,
      ),
      shape: RoundedRectangleBorder(borderRadius: context.radiusAllCircularMedium),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RecipeCircularButton(
              text: const LocaleText(
                text: LocaleKeys.ok,
              ),
              textColor: Colors.black,
              color: Colors.white,
              width: context.screenWidth / 4,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}
