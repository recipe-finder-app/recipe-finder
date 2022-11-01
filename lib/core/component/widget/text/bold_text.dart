import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  const BoldText({Key? key, required this.text, this.color, this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Poppins',
          color: color ?? Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: fontSize ?? 14),
    );
  }
}
