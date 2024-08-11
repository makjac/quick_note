import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/hive/hive_keys.dart';

void main() {
  group('HiveBoxes', () {
    test('should have the correct values and names', () {
      const values = HiveBoxes.values;

      expect(values.length, 1);

      expect(values[0], HiveBoxes.note);

      expect(values[0].name, "_bNnote_");
    });
  });
}
