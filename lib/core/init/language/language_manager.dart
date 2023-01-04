import 'dart:ui';

import 'package:flutter/material.dart';

import '../../constant/enum/supported_languages_enum.dart';

class LanguageManager {
  static final LanguageManager _instance = LanguageManager._init();
  static LanguageManager get instance => _instance;
  LanguageManager._init();

  /*static LanguageManager? _instance;
  static LanguageManager get instance => _instance ??= LanguageManager._init();
  LanguageManager._init();*/

  final enLocale = const Locale('en', 'US');
  final trLocale = const Locale('tr', 'TR');
  List<Locale> get supportedLocalesList => [enLocale, trLocale];
  List<String> languageList = [SupportedLanguages.EN.name, SupportedLanguages.TR.name];

  Locale? startLocale() {
    Locale deviceLocale = PlatformDispatcher.instance.locale;
    if (deviceLocale == enLocale) {
      return enLocale;
    } else if (deviceLocale == trLocale) {
      return trLocale;
    } else {
      return enLocale;
    }
  }
}
