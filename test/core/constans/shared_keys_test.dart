import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/constans/shared_keys.dart';

void main() {
  group('SharedKeys Enum', () {
    test('should have correct number of values', () {
      expect(SharedKeys.values.length, 3);
    });

    test('should have correct values', () {
      expect(SharedKeys.values[0], SharedKeys.languagePref);
      expect(SharedKeys.values[1], SharedKeys.themePref);
      expect(SharedKeys.values[2], SharedKeys.colapseSideMenuPerf);
    });
  });
}
