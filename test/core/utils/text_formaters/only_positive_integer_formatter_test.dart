import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/utils/text_formaters/only_positive_integer_formatter.dart';

void main() {
  group('OnlyPositiveIntegerFormatter', () {
    late OnlyPositiveIntegerFormatter formatter;

    setUp(() {
      formatter = OnlyPositiveIntegerFormatter(maxLength: 3);
    });

    test('should allow valid positive integers up to maxLength', () {
      const oldValue = TextEditingValue(text: '');
      const newValue = TextEditingValue(text: '123');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, '123');
      expect(result.selection.baseOffset, 3);
    });

    test('should remove non-numeric characters', () {
      const oldValue = TextEditingValue(text: '');
      const newValue = TextEditingValue(text: '12a34b');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, '');
      expect(result.selection.baseOffset, -1);
    });

    test('should handle empty input', () {
      const oldValue = TextEditingValue(text: '');
      const newValue = TextEditingValue(text: '');

      final result = formatter.formatEditUpdate(oldValue, newValue);

      expect(result.text, '');
      expect(result.selection.baseOffset, 0);
    });
  });
}
