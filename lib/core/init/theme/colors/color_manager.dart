import 'package:flutter/material.dart';

part './kind/light_color.dart';
part './kind/dark_color.dart';

@immutable
class _AppColors {
  final Color white = const Color(0xffffffff);
  final Color green = const Color(0xff7bed8d);
  final Color black = const Color(0xff000000);
  final Color mediumGreyBold = const Color(0xff748a9d);
  final Color lighterGrey = const Color(0xfff0f4f8);
  final Color lightGrey = const Color(0xffdbe2ed);
  final Color darkerGrey = const Color(0xff404e5a);
  final Color darkGrey = const Color(0xff4e5d6a);
}

abstract class IColors {
  _AppColors get colors;
  Color? scaffoldBackgroundColor;
  Color? appBarColor;
  Color? tabBarColor;
  Color? tabbarSelectedColor;
  Color? tabbarNormalColor;
  Brightness? brightness;

  ColorScheme? colorScheme;
}
