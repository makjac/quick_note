import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/l10n/app_language.dart';

void main() {
  group('AppLanguage', () {
    test('should have correct locales for each language', () {
      expect(AppLanguage.values.length, 18);

      expect(AppLanguage.english.locale, const Locale('en'));
      expect(AppLanguage.polish.locale, const Locale('pl'));
      expect(AppLanguage.german.locale, const Locale('de'));
      expect(AppLanguage.spanish.locale, const Locale('es'));
      expect(AppLanguage.portuguese.locale, const Locale('pt'));
      expect(AppLanguage.french.locale, const Locale('fr'));
      expect(AppLanguage.russian.locale, const Locale('ru'));
      expect(AppLanguage.hindi.locale, const Locale('hi'));
      expect(AppLanguage.chinese.locale, const Locale('zh'));
      expect(AppLanguage.arabic.locale, const Locale('ar'));
      expect(AppLanguage.czech.locale, const Locale('cs'));
      expect(AppLanguage.hungarian.locale, const Locale('hu'));
      expect(AppLanguage.indonesian.locale, const Locale('id'));
      expect(AppLanguage.italian.locale, const Locale('it'));
      expect(AppLanguage.japanese.locale, const Locale('ja'));
      expect(AppLanguage.korean.locale, const Locale('ko'));
      expect(AppLanguage.ukrainian.locale, const Locale('uk'));
      expect(AppLanguage.vietnamese.locale, const Locale('vi'));
    });

    test('should have correct language codes', () {
      expect(AppLanguage.english.locale.languageCode, 'en');
      expect(AppLanguage.polish.locale.languageCode, 'pl');
      expect(AppLanguage.german.locale.languageCode, 'de');
      expect(AppLanguage.spanish.locale.languageCode, 'es');
      expect(AppLanguage.portuguese.locale.languageCode, 'pt');
      expect(AppLanguage.french.locale.languageCode, 'fr');
      expect(AppLanguage.russian.locale.languageCode, 'ru');
      expect(AppLanguage.hindi.locale.languageCode, 'hi');
      expect(AppLanguage.chinese.locale.languageCode, 'zh');
      expect(AppLanguage.arabic.locale.languageCode, 'ar');
      expect(AppLanguage.czech.locale.languageCode, 'cs');
      expect(AppLanguage.hungarian.locale.languageCode, 'hu');
      expect(AppLanguage.indonesian.locale.languageCode, 'id');
      expect(AppLanguage.italian.locale.languageCode, 'it');
      expect(AppLanguage.japanese.locale.languageCode, 'ja');
      expect(AppLanguage.korean.locale.languageCode, 'ko');
      expect(AppLanguage.ukrainian.locale.languageCode, 'uk');
      expect(AppLanguage.vietnamese.locale.languageCode, 'vi');
    });
  });
}
