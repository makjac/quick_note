import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/error/failure/file_not_found_failure.dart';

void main() {
  group('FileNotFoundFailure', () {
    test('should have a default message', () {
      const failure = FileNotFoundFailure();
      expect(failure.message, 'File not found');
    });

    test('should allow custom message', () {
      const customMessage = 'Custom file not found message';
      const failure = FileNotFoundFailure(message: customMessage);
      expect(failure.message, customMessage);
    });
  });
}
