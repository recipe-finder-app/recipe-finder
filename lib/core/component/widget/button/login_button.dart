import 'package:flutter/material.dart';
import 'package:recipe_finder/core/component/widget/button/authenticate_circular_button.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  const LoginButton({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthenticateCircularButton(
      text: text,
      color: ColorConstants.instance.oriolesOrange,
      onPressed: onPressed,
    );
  }
}
