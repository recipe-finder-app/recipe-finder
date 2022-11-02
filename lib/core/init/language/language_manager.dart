import 'package:flutter/material.dart';

class LanguageManager {
  static LanguageManager? _instance;
  static LanguageManager get instance {
    _instance ??= LanguageManager._init();
    return _instance!;
  }

  LanguageManager._init();

  final enLocale = Locale('en', 'US');
  final trLocale = Locale('tr', 'TR');
  final gerLocale = Locale('de', 'DE');
  List<Locale> get supportedLocalesList => [enLocale, trLocale,gerLocale];
  List<String> languageList = ["EN","TR","DE"];
}
