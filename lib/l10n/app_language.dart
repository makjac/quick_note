import 'package:flutter/material.dart';

enum AppLanguage {
  english(locale: Locale('en')),
  polish(locale: Locale('pl')),
  german(locale: Locale('de')),
  spanish(locale: Locale('es')),
  portuguese(locale: Locale('pt')),
  french(locale: Locale('fr')),
  russian(locale: Locale('ru')),
  hindi(locale: Locale('hi')),
  chinese(locale: Locale('zh'));

  final Locale locale;

  const AppLanguage({required this.locale});
}
