import 'package:flutter/material.dart';

import '../text_theme.dart';

class TextThemeLight implements ITextTheme {
  @override
  late final TextTheme data;

  @override
  TextStyle? bodyText1;

  @override
  TextStyle? bodyText2;

  @override
  TextStyle? headline1;

  @override
  TextStyle? headline3;

  @override
  TextStyle? headline4;

  @override
  TextStyle? headline5;

  @override
  TextStyle? headline6;

  @override
  TextStyle? subtitle1;

  @override
  TextStyle? subtitle2;
  final Color? primaryColor;

  TextThemeLight(this.primaryColor) {
    data = const TextTheme(
      headline5: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      subtitle1: TextStyle(fontSize: 16.0),
    ).apply(bodyColor: primaryColor);
  }

  @override
  String? fontFamily;
}
