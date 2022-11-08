import 'package:flutter/material.dart';
import 'package:recipe_finder/product/widget/button/authenticate_circular_button.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color color;
  const LoginButton({
    Key? key,
    this.onPressed,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthenticateCircularButton(
      text: text,
      color: color,
      onPressed: onPressed,
    );
  }
}
