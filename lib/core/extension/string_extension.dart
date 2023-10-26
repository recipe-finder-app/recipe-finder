import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

extension StringLocalizationExtension on String {
  String get locale => tr();
}

extension ToColorExtension on String {
  Color get toColor => Color(int.parse("0xFF$this")).withOpacity(0.1);
}