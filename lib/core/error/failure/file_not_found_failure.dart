import 'package:quick_note/core/error/failure/failure.dart';

class FileNotFoundFailure extends Failure {
  const FileNotFoundFailure({super.message = 'File not found'});
}
