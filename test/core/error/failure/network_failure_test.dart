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
  });
}
