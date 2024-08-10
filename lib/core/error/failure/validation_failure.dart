import 'package:quick_note/core/error/failure/failure.dart';

class ValidationFailure extends Failure {
  const ValidationFailure() : super(message: 'Validation error occurred.');
}
