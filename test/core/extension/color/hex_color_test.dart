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
  });
}
