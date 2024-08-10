import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/Parsing_failure.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/error/failure/network_failure.dart';
import 'package:quick_note/core/error/failure/validation_failure.dart';
import 'package:quick_note/feature/notebook/data/datasource/bookmarks_remote_datasource.dart';
import 'package:quick_note/feature/notebook/domain/entity/favicon_data.dart';
import 'package:quick_note/feature/notebook/domain/repository/bookmarks_repository.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  const BookmarkRepositoryImpl({required this.datasource});

  final BookmarksRemoteDatasource datasource;

  @override
  Future<Either<Failure, String?>> fetchBestFaviconUrl(String url) async {
    try {
      final result = await datasource.fetchBestFaviconUrl(url);
      return Right(result);
    } catch (e) {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<FaviconData>>> fetchAllFaviconUrls(
      String url) async {
    try {
      final result = await datasource.fetchAllFaviconUrls(url);
      return Right(result);
    } catch (e) {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<FaviconData>>> fetchFaviconsByType(
      String url, String type) async {
    try {
      final result = await datasource.fetchFaviconsByType(url, type);
      return Right(result);
    } catch (e) {
      return const Left(ParsingFailure());
    }
  }

  @override
  Future<Either<Failure, List<FaviconData>>> fetchFaviconsBySizeRange(
      String url, int minSize, int maxSize) async {
    try {
      final result =
          await datasource.fetchFaviconsBySizeRange(url, minSize, maxSize);
      return Right(result);
    } catch (e) {
      return const Left(ValidationFailure());
    }
  }
}
