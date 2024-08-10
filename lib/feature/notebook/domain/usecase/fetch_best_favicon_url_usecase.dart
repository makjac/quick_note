import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/usecase/usecase.dart';
import 'package:quick_note/feature/notebook/domain/repository/bookmarks_repository.dart';

class FetchBestFaviconUrlUsecase extends UseCase<String?, String> {
  FetchBestFaviconUrlUsecase({required this.repository});

  final BookmarkRepository repository;

  @override
  Future<Either<Failure, String?>> call(String params) async {
    return await repository.fetchBestFaviconUrl(params);
  }
}
