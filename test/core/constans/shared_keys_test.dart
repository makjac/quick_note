import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/constans/shared_keys.dart';

void main() {
  group('SharedKeys Enum', () {
    test('should have correct number of values', () {
      expect(SharedKeys.values.length, 3);
    });
  });
}
