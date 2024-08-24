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
  arabic(locale: Locale('ar')),
  chinese(locale: Locale('zh')),
  czech(locale: Locale('cs')),
  hungarian(locale: Locale('hu')),
  indonesian(locale: Locale('id')),
  italian(locale: Locale('it')),
  japanese(locale: Locale('ja')),
  korean(locale: Locale('ko')),
  ukrainian(locale: Locale('uk')),
  vietnamese(locale: Locale('vi'));

  final Locale locale;

  const AppLanguage({required this.locale});
}
