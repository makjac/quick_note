import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/error/failure/cache_failure.dart';

void main() {
  group('CacheFailure', () {
    test('should be an instance of Failure', () {
      const failure = CacheFailure();
      expect(failure, isA<Failure>());
    });

    test('should have the correct default message', () {
      const failure = CacheFailure();
      expect(failure.message, '');
    });

    test('should have the correct message when provided', () {
      const customMessage = 'Custom cache error message';
      const failure = CacheFailure(message: customMessage);
      expect(failure.message, customMessage);
    });

    test('should be equatable', () {
      const failure1 = CacheFailure();
      const failure2 = CacheFailure();
      const failure3 = CacheFailure(message: 'Different message');

      expect(failure1, equals(failure2));
      expect(failure1, isNot(equals(failure3)));
    });

    test('should have an empty props list', () {
      const failure = CacheFailure();
      expect(failure.props, ['']);
    });
  });
}
