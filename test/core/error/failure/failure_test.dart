import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/error/failure/failure.dart';

class _TestFailure extends Failure {
  const _TestFailure({super.message});
}

void main() {
  group('Failure', () {
    test('should have the correct default message', () {
      const failure = _TestFailure();
      expect(failure.message, '');
    });

    test('should have the correct message', () {
      const customMessage = 'Custom error message';
      const failure = _TestFailure(message: customMessage);
      expect(failure.message, customMessage);
    });
  });
}
