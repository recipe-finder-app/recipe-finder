import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get screenHeight => mediaQuery.size.height;
  double get screenWidth => mediaQuery.size.width;
  double get veryLowValue => screenHeight * 0.008;
  double get lowValue => screenHeight * 0.01;
  double get normalValue => screenHeight * 0.02;
  double get mediumValue => screenHeight * 0.04;
  double get highValue => screenHeight * 0.07;
  double get veryHighValue => screenHeight * 0.1;
  double get veryveryHighValue => screenHeight * 0.3;
  double get veryyHighValue => screenHeight * 0.21;
  double get normalhighValue => screenHeight * 0.13;
  double get maxValue => screenHeight * 0.07;
  double get maxValueWidth => screenWidth * 0.86;
  double get veryValueWidth => screenWidth * 0.95;
  double get normalValueWidth => screenWidth * 0.71;
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;
}

extension PaddingExtensionAll on BuildContext {
  EdgeInsets get paddingVeryLowAll => EdgeInsets.all(veryLowValue);
  EdgeInsets get paddingLowAll => EdgeInsets.all(lowValue);
  EdgeInsets get paddingNormalAll => EdgeInsets.all(normalValue);
  EdgeInsets get paddingMediumAll => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHighAll => EdgeInsets.all(veryHighValue);

  EdgeInsets get paddingLowLeft => EdgeInsets.only(left: normalValue);
  EdgeInsets get paddingLowRight => EdgeInsets.only(right: normalValue);
  EdgeInsets get paddingMediumRight => EdgeInsets.only(right: mediumValue);
  EdgeInsets get paddingLowRightLow => EdgeInsets.only(right: lowValue);
  EdgeInsets get paddingLowEdges =>
      EdgeInsets.only(left: lowValue, right: lowValue);
  EdgeInsets get paddingLowRightTop => EdgeInsets.only(top: normalValue);
  EdgeInsets get paddingNormalEdges => EdgeInsets.only(
        left: normalValue,
        right: normalValue,
        top: normalValue,
      );

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
      EdgeInsets.only(top: veryHighValue, bottom: veryHighValue);

  EdgeInsets get paddingLowOnlyTop => EdgeInsets.only(top: lowValue);
  EdgeInsets get paddingNormalOnlyTop => EdgeInsets.only(top: normalValue);
  EdgeInsets get paddingMediumOnlyTop => EdgeInsets.only(top: mediumValue);
  EdgeInsets get paddingHighOnlyTop => EdgeInsets.only(top: veryHighValue);
}

extension PaddingExtensionSymetric on BuildContext {
  EdgeInsets get paddingLowVertical => EdgeInsets.symmetric(vertical: lowValue);
  EdgeInsets get paddingNormalVertical =>
      EdgeInsets.symmetric(vertical: normalValue);
  EdgeInsets get paddingMediumVertical =>
      EdgeInsets.symmetric(vertical: mediumValue);
  EdgeInsets get paddingHighVertical =>
      EdgeInsets.symmetric(vertical: veryHighValue);

  EdgeInsets get paddingLowHorizontal =>
      EdgeInsets.symmetric(horizontal: lowValue);
  EdgeInsets get paddingNormalHorizontal =>
      EdgeInsets.symmetric(horizontal: normalValue);
  EdgeInsets get paddingMediumHorizontal =>
      EdgeInsets.symmetric(horizontal: mediumValue);
  EdgeInsets get paddingHighHorizontal =>
      EdgeInsets.symmetric(horizontal: veryHighValue);
}

extension PageExtension on BuildContext {
  Color get randomColor => Colors.primaries[Random().nextInt(17)];
}

extension DurationExtension on BuildContext {
  Duration get veryLowDuration => const Duration(milliseconds: 500);
  Duration get lowDuration => const Duration(seconds: 1);
}

extension SizedBoxExtension on BuildContext {
  SizedBox get veryLowSizedBox => SizedBox(height: veryLowValue);
  SizedBox get lowSizedBox => SizedBox(height: lowValue);
  SizedBox get normalSizedBox => SizedBox(height: normalValue);
  SizedBox get mediumSizedBox => SizedBox(height: mediumValue);
  SizedBox get highSizedBox => SizedBox(height: highValue);
  SizedBox get veryHighSizedBox => SizedBox(height: veryHighValue);
  SizedBox get veryveryHighSizedBox => SizedBox(height: veryveryHighValue);

  SizedBox get veryLowSizedBoxWidth => SizedBox(width: veryLowValue);
  SizedBox get lowSizedBoxWidth => SizedBox(width: lowValue);
  SizedBox get normalSizedBoxWidth => SizedBox(width: normalValue);
  SizedBox get mediumSizedBoxWidth => SizedBox(width: mediumValue);
  SizedBox get highSizedBoxWidth => SizedBox(width: highValue);
  SizedBox get veryHighSizedBoxWidth => SizedBox(width: veryHighValue);
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

extension BorderExtension on BuildContext {
  BorderRadius get radiusAllCircularMin => BorderRadius.circular(10.0);
  BorderRadius get radiusAllCircularMedium => BorderRadius.circular(15.0);
  BorderRadius get radiusAllCircularHigh => BorderRadius.circular(35.0);
  BorderRadius get radiusAllCircularVeryHigh => BorderRadius.circular(50.0);

  BorderRadius get radiusTopCircularHigh => const BorderRadius.only(
        topLeft: Radius.circular(35),
        topRight: Radius.circular(35),
      );
  BorderRadius get radiusTopCircularMedium => const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      );
  BorderRadius get radiusTopCircularMin => const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      );
  BorderRadius get radiusBottomCircularMin => const BorderRadius.only(
        bottomLeft: Radius.circular(10.0),
        bottomRight: Radius.circular(10.0),
      );
  BorderRadius get radiusBottomCircularMedium => const BorderRadius.only(
        bottomLeft: Radius.circular(15.0),
        bottomRight: Radius.circular(15.0),
      );
}
