import 'package:flutter/material.dart';

enum AppLanguage {
  english(locale: Locale('en')),
  polish(locale: Locale('pl'));

  final Locale locale;

  const AppLanguage({required this.locale});
}
