import 'package:quick_note/core/error/failure/failure.dart';

class UnknownFailure extends Failure {
  const UnknownFailure() : super(message: 'An unknown error occurred.');
}
