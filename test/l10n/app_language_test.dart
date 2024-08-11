import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/l10n/app_language.dart';

void main() {
  group('AppLanguage', () {
    test('should have correct locales for each language', () {
      expect(AppLanguage.values.length, 9);

      expect(AppLanguage.english.locale, const Locale('en'));
      expect(AppLanguage.polish.locale, const Locale('pl'));
      expect(AppLanguage.german.locale, const Locale('de'));
      expect(AppLanguage.spanish.locale, const Locale('es'));
      expect(AppLanguage.portuguese.locale, const Locale('pt'));
      expect(AppLanguage.french.locale, const Locale('fr'));
      expect(AppLanguage.russian.locale, const Locale('ru'));
      expect(AppLanguage.hindi.locale, const Locale('hi'));
      expect(AppLanguage.chinese.locale, const Locale('zh'));
    });
  });
}
