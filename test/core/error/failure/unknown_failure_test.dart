import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/error/failure/unknown_failure.dart';

void main() {
  group('UnknownFailure', () {
    test('should be an instance of Failure', () {
      const failure = UnknownFailure();
      expect(failure, isA<Failure>());
    });

    test('should have the correct default message', () {
      const failure = UnknownFailure();
      expect(failure.message, 'An unknown error occurred.');
    });

    test('should be equatable', () {
      const failure1 = UnknownFailure();
      const failure2 = UnknownFailure();

      expect(failure1, equals(failure2));
    });

    test('should have an empty props list', () {
      const failure = UnknownFailure();
      expect(failure.props, ['An unknown error occurred.']);
    });
  });
}
