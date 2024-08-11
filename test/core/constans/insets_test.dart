import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/constans/insets.dart';

void main() {
  group('Insets', () {
    test('should have correct none value', () {
      expect(Insets.none, 0.0);
    });
  });
}
