import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/error/failure/parsing_failure.dart';

void main() {
  group('ParsingFailure', () {
    test('should be an instance of Failure', () {
      const failure = ParsingFailure();
      expect(failure, isA<Failure>());
    });

    test('should have the correct default message', () {
      const failure = ParsingFailure();
      expect(failure.message, 'Failed to parse data.');
    });

    test('should be equatable', () {
      const failure1 = ParsingFailure();
      const failure2 = ParsingFailure();

      expect(failure1, equals(failure2));
    });

    test('should have an empty props list', () {
      const failure = ParsingFailure();
      expect(failure.props, ['Failed to parse data.']);
    });
  });
}
