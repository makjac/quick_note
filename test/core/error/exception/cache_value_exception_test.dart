import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/error/exception/cache_value_exception.dart';

void main() {
  group('CacheValueException', () {
    test('should be an instance of Exception', () {
      final exception = CacheValueException();
      expect(exception, isA<Exception>());
    });

    test('should be an instance of CacheValueException', () {
      final exception = CacheValueException();
      expect(exception, isA<CacheValueException>());
    });
  });
}
