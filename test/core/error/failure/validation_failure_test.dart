import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/error/failure/validation_failure.dart';

void main() {
  group('ValidationFailure', () {
    test('should be an instance of Failure', () {
      const failure = ValidationFailure();
      expect(failure, isA<Failure>());
    });

    test('should have the correct default message', () {
      const failure = ValidationFailure();
      expect(failure.message, 'Validation error occurred.');
    });
  });
}
