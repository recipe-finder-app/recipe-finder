import 'package:flutter/material.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';

class AlertDialogSuccess extends StatelessWidget {
  final String text;
  final Color? textColor;
  final String? fontFamily;
  final String? buttonText;
  final bool? locale = false;

  const AlertDialogSuccess({Key? key, required this.text, this.buttonText, this.textColor, this.fontFamily}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green,
      content: Text(
        text,
        style: TextStyle(color: textColor ?? Colors.white, fontFamily: fontFamily),
        textAlign: TextAlign.center,
      ),
      title: const Icon(
        Icons.check,
        color: Colors.white,
        size: 50,
      ),
      shape: RoundedRectangleBorder(borderRadius: context.radiusAllCircularMedium),
    );
  }
}
