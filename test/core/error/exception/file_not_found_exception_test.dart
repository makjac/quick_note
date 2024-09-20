import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/error/exception/file_not_found_exception.dart';

void main() {
  group('FileNotFoundException', () {
    test('should return the default message when no message is provided', () {
      const exception = FileNotFoundException();
      expect(exception.message, 'File not found');
      expect(exception.toString(), 'FileNotFoundException: File not found');
    });
  });
}
