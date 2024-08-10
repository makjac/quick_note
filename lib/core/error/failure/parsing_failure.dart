import 'package:quick_note/core/error/failure/failure.dart';

class ParsingFailure extends Failure {
  const ParsingFailure() : super(message: 'Failed to parse data.');
}
