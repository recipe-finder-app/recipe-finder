import 'package:flutter/material.dart';
import 'package:recipe_finder/product/widget/button/recipe_circular_button.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color color;
  final Color? textColor;
  const LoginButton({
    Key? key,
    this.onPressed,
    required this.text,
    required this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RecipeCircularButton(
      text: text,
      textColor: textColor,
      color: color,
      onPressed: onPressed,
    );
  }
}
