import 'package:quick_note/core/error/failure/failure.dart';

class NetworkFailure extends Failure {
  const NetworkFailure() : super(message: 'Network error occurred.');
}
