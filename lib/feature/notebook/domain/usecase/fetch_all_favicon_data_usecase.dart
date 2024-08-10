import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/usecase/usecase.dart';
import 'package:quick_note/feature/notebook/domain/entity/favicon_data.dart';
import 'package:quick_note/feature/notebook/domain/repository/bookmarks_repository.dart';

class FetchAllFaviconDataUsecase extends UseCase<List<FaviconData>, String> {
  FetchAllFaviconDataUsecase({required this.repository});

  final BookmarkRepository repository;

  @override
  Future<Either<Failure, List<FaviconData>>> call(String params) async {
    return await repository.fetchAllFaviconUrls(params);
  }
}
