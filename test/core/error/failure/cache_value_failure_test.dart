import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/error/failure/cache_value_failure.dart';

void main() {
  group('CacheValueFailure', () {
    test('should be an instance of Failure', () {
      const failure = CacheValueFailure();
      expect(failure, isA<Failure>());
    });

    test('should have the correct default message', () {
      const failure = CacheValueFailure();
      expect(failure.message, '');
    });
  });
}
