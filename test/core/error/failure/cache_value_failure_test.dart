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

    test('should have the correct message when provided', () {
      const customMessage = 'Custom cache value error message';
      const failure = CacheValueFailure(message: customMessage);
      expect(failure.message, customMessage);
    });

    test('should be equatable', () {
      const failure1 = CacheValueFailure();
      const failure2 = CacheValueFailure();
      const failure3 = CacheValueFailure(message: 'Different message');

      expect(failure1, equals(failure2));
      expect(failure1, isNot(equals(failure3)));
    });

    test('should have an empty props list', () {
      const failure = CacheValueFailure();
      expect(failure.props, ['']);
    });
  });
}
