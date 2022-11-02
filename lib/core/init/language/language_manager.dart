import 'package:flutter/material.dart';

import '../../constant/enum/supported_languages_enum.dart';

class LanguageManager {
  static LanguageManager? _instance;
  static LanguageManager get instance {
    _instance ??= LanguageManager._init();
    return _instance!;
  }

  LanguageManager._init();

  final enLocale = const Locale('en', 'US');
  final trLocale = const Locale('tr', 'TR');
  List<Locale> get supportedLocalesList => [enLocale, trLocale];
  List<String> languageList = [
    SupportedLanguages.EN.name,
    SupportedLanguages.TR.name
  ];
}
