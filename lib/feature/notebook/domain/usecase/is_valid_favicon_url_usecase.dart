class IsValidFaviconUrlUsecase extends UseCase<bool, String> {
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/usecase/usecase.dart';
import 'package:quick_note/feature/notebook/domain/repository/bookmarks_repository.dart';

class IsValidFaviconUrlUsecase extends UseCase<bool, String> {
  IsValidFaviconUrlUsecase({required this.repository});

  final BookmarkRepository repository;

  @override
  Future<Either<Failure, bool>> call(String params) async {
    return await repository.isValidFaviconUrl(params);
  }
}
