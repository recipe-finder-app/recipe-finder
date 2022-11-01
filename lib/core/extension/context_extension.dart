import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get screenHeight => mediaQuery.size.height;
  double get screenWidth => mediaQuery.size.width;

  double get lowValue => screenHeight * 0.01;
  double get normalValue => screenHeight * 0.02;
  double get mediumValue => screenHeight * 0.04;
  double get highValue => screenHeight * 0.1;
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;
}

extension PaddingExtensionAll on BuildContext {
  EdgeInsets get paddingLowAll => EdgeInsets.all(lowValue);
  EdgeInsets get paddingNormalAll => EdgeInsets.all(normalValue);
  EdgeInsets get paddingMediumAll => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHighAll => EdgeInsets.all(highValue);

  EdgeInsets get paddingLowEdges =>
      EdgeInsets.only(left: lowValue, right: lowValue);
  EdgeInsets get paddingNormalEdges =>
      EdgeInsets.only(left: normalValue, right: normalValue);
  EdgeInsets get paddingMediumEdges =>
      EdgeInsets.only(left: mediumValue, right: mediumValue);
  EdgeInsets get paddingHighEdges =>
      EdgeInsets.only(left: highValue, right: highValue);

  EdgeInsets get paddingLowTopBottom =>
      EdgeInsets.only(top: lowValue, bottom: lowValue);
  EdgeInsets get paddingNormalTopBottom =>
      EdgeInsets.only(top: normalValue, bottom: normalValue);
  EdgeInsets get paddingMediumTopBottom =>
      EdgeInsets.only(top: mediumValue, bottom: mediumValue);
  EdgeInsets get paddingHighTopBottom =>
      EdgeInsets.only(top: highValue, bottom: highValue);

  EdgeInsets get paddingLowOnlyTop => EdgeInsets.only(top: lowValue);
  EdgeInsets get paddingNormalOnlyTop => EdgeInsets.only(top: normalValue);
  EdgeInsets get paddingMediumOnlyTop => EdgeInsets.only(top: mediumValue);
  EdgeInsets get paddingHighOnlyTop => EdgeInsets.only(top: highValue);
}

extension PaddingExtensionSymetric on BuildContext {
  EdgeInsets get paddingLowVertical => EdgeInsets.symmetric(vertical: lowValue);
  EdgeInsets get paddingNormalVertical =>
      EdgeInsets.symmetric(vertical: normalValue);
  EdgeInsets get paddingMediumVertical =>
      EdgeInsets.symmetric(vertical: mediumValue);
  EdgeInsets get paddingHighVertical =>
      EdgeInsets.symmetric(vertical: highValue);

  EdgeInsets get paddingLowHorizontal =>
      EdgeInsets.symmetric(horizontal: lowValue);
  EdgeInsets get paddingNormalHorizontal =>
      EdgeInsets.symmetric(horizontal: normalValue);
  EdgeInsets get paddingMediumHorizontal =>
      EdgeInsets.symmetric(horizontal: mediumValue);
  EdgeInsets get paddingHighHorizontal =>
      EdgeInsets.symmetric(horizontal: highValue);
}

extension PageExtension on BuildContext {
  Color get randomColor => Colors.primaries[Random().nextInt(17)];
}

extension DurationExtension on BuildContext {
  Duration get veryLowDuration => const Duration(milliseconds: 500);
  Duration get lowDuration => const Duration(seconds: 1);
}

extension SizedBoxExtension on BuildContext {
  SizedBox get veryLowSizedBox => const SizedBox(height: 5);
  SizedBox get lowSizedBox => const SizedBox(height: 10);
  SizedBox get mediumSizedBox => const SizedBox(height: 15);
  SizedBox get highSizedBox => const SizedBox(height: 25);
  SizedBox get veryHighSizedBox => const SizedBox(height: 50);
}

extension ScreenOrientationExtension on BuildContext {
  Future<void> get landScapeView => SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
  Future<void> get portraitUpView => SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
}
