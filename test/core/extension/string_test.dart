import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/extension/string.dart';

void main() {
  group('StringExtension', () {
    test('capitalize should capitalize the first letter and lowercase the rest',
        () {
      expect('hello world'.capitalize(), equals('Hello world'));
      expect('HELLO WORLD'.capitalize(), equals('Hello world'));
      expect('hElLo wOrLd'.capitalize(), equals('Hello world'));
      expect('a'.capitalize(), equals('A'));
      expect(''.capitalize(), equals(''));
    });

    test('capitalize should handle single character string', () {
      expect('a'.capitalize(), equals('A'));
      expect('b'.capitalize(), equals('B'));
    });

    test('capitalize should return an empty string for empty input', () {
      expect(''.capitalize(), equals(''));
    });
  });
}
