import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/error/failure/network_failure.dart';

void main() {
  group('NetworkFailure', () {
    test('should be an instance of Failure', () {
      const failure = NetworkFailure();
      expect(failure, isA<Failure>());
    });

    test('should have the correct default message', () {
      const failure = NetworkFailure();
      expect(failure.message, 'Network error occurred.');
    });

    test('should be equatable', () {
      const failure1 = NetworkFailure();
      const failure2 = NetworkFailure();

      expect(failure1, equals(failure2));
    });

    test('should have an empty props list', () {
      const failure = NetworkFailure();
      expect(failure.props, ['Network error occurred.']);
    });
  });
}
