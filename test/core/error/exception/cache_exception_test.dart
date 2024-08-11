import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/error/exception/cache_exception.dart';

void main() {
  group('CacheException', () {
    test('should be an instance of Exception', () {
      final exception = CacheException();
      expect(exception, isA<Exception>());
    });
  });
}
