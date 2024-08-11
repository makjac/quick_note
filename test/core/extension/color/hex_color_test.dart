import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/extension/color/hex_color.dart';

void main() {
  group('HexColor', () {
    test('fromHex should convert hex string to Color', () {
      expect(HexColor.fromHex('#aabbcc'), equals(const Color(0xffaabbcc)));
      expect(HexColor.fromHex('aabbcc'), equals(const Color(0xffaabbcc)));
      expect(HexColor.fromHex('#ffaabbcc'), equals(const Color(0xffaabbcc)));
      expect(HexColor.fromHex('ffaabbcc'), equals(const Color(0xffaabbcc)));
    });

    test('fromHex should return grey color for invalid hex string', () {
      expect(HexColor.fromHex('#9e9e9e').value, equals(Colors.grey.value));
      expect(HexColor.fromHex('#f44336').value, equals(Colors.red.value));
      expect(HexColor.fromHex('#2196f3').value, equals(Colors.blue.value));
    });

    test('toHex should convert Color to hex string with leading hash', () {
      expect(const Color(0xffaabbcc).toHex(), equals('#ffaabbcc'));
      expect(const Color(0xff000000).toHex(), equals('#ff000000'));
    });

    test('toHex should convert Color to hex string without leading hash', () {
      expect(const Color(0xffaabbcc).toHex(leadingHashSign: false),
          equals('ffaabbcc'));
      expect(const Color(0xff000000).toHex(leadingHashSign: false),
          equals('ff000000'));
    });
  });
}
