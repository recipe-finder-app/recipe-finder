import 'package:flutter/material.dart';

class ColorConstants {
  static ColorConstants instance = ColorConstants._init();
  ColorConstants._init();

  final appBackgroundColor = const BoxDecoration(
      gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xFF034A72),
      Color(0xFF3182B6),
      Color(0xFFFFFFFF),
    ],
  ));
  final appBackgroundBlueColor = const BoxDecoration(
      gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xFF3182B6),
      Color(0xFF034A72),
    ],
  ));

  final registerBackgroundColor = const BoxDecoration(
      gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFF2F2F2),
      Color(0xFFBDCCD4),
    ],
  ));
  final buttonGradientBlueColor = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xFF030303).withOpacity(0.3),
      const Color(0xFFefefbb).withOpacity(0.3),
    ],
  );
  final transparentColor = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xFF636363).withOpacity(0.1),
      const Color(0xFFefefbb).withOpacity(0.1),
    ],
  );
  final gradientGreenColor = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.greenAccent,
      Colors.green,
    ],
  );
  Color loginButtonColor = const Color(0xffff9b511);
  Color brightNavyBlue = const Color(0xFF1E76D6);
  Color russianViolet = const Color(0xFF1F1346);
  Color oriolesOrange = const Color(0xFFF6411A);
}
