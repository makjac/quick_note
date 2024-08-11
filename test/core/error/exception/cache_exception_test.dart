import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/error/exception/cache_exception.dart';

void main() {
  group('CacheException', () {
    test('should be an instance of Exception', () {
      final exception = CacheException();
      expect(exception, isA<Exception>());
    });

    test('should be an instance of CacheException', () {
      final exception = CacheException();
      expect(exception, isA<CacheException>());
    });

    test('should have no additional properties or methods', () {
      final exception = CacheException();
      expect(exception.toString(), 'Instance of \'CacheException\'');
    });
  });
}
