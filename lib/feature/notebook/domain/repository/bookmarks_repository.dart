import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/feature/notebook/domain/entity/favicon_data.dart';

abstract class BookmarkRepository {
  Future<Either<Failure, String?>> fetchBestFaviconUrl(String url);
  Future<Either<Failure, List<FaviconData>>> fetchAllFaviconUrls(String url);
  Future<Either<Failure, List<FaviconData>>> fetchFaviconsByType(
      String url, String type);
  Future<Either<Failure, List<FaviconData>>> fetchFaviconsBySizeRange(
      String url, int minSize, int maxSize);
  Future<Either<Failure, bool>> isValidFaviconUrl(String url);

  Future<Either<Failure, List<FaviconData>>> fetchFaviconsByDomain(
      String domain);
}
