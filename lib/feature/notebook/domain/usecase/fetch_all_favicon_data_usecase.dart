import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/usecase/usecase.dart';
import 'package:quick_note/feature/notebook/domain/entity/favicon_data.dart';
import 'package:quick_note/feature/notebook/domain/repository/bookmarks_repository.dart';

/// Use case for fetching all available favicon data for a specified URL.
///
/// This use case is responsible for retrieving all favicon URLs and their associated metadata (sizes and types) for a given website.
///
/// It interacts with the `BookmarkRepository` to fetch the favicon data.
///
/// Example usage:
/// ```dart
/// final fetchAllFaviconDataUsecase = FetchAllFaviconDataUsecase(repository: yourFaviconRepository);
///
/// final result = await fetchAllFaviconDataUsecase.call('https://example.com');
///
/// result.fold(
///   (failure) => print('Error: $failure'),
///   (faviconDataList) => faviconDataList.forEach((faviconData) {
///     print('Favicon URL: ${faviconData.url}');
///     print('Sizes: ${faviconData.sizes}');
///     print('Type: ${faviconData.type}');
///   }),
/// );
/// ```
///
/// This example demonstrates how to use the `FetchAllFaviconDataUsecase` to fetch all available favicon data for the provided URL,
/// handle potential errors, and process the retrieved favicon data.
class FetchAllFaviconDataUsecase extends UseCase<List<FaviconData>, String> {
  /// Creates an instance of [FetchAllFaviconDataUsecase].
  ///
  /// [repository] - The repository used to fetch favicon URLs and metadata.
  FetchAllFaviconDataUsecase({required this.repository});

  final BookmarkRepository repository;

  /// Fetches all available favicon data for the specified URL.
  ///
  /// This method calls the repository to retrieve all favicon URLs and their associated metadata such as sizes and types.
  @override
  Future<Either<Failure, List<FaviconData>>> call(String params) async {
    return await repository.fetchAllFaviconUrls(params);
  }
}
