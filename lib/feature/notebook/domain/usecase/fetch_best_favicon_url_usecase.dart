import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/usecase/usecase.dart';
import 'package:quick_note/feature/notebook/domain/repository/bookmarks_repository.dart';

/// Use case for fetching the best favicon URL for a specified website.
///
/// This use case is responsible for retrieving the most suitable favicon URL
/// for a given website. The best favicon is determined based on criteria such
/// as size or type, depending on the implementation in the repository.
///
/// It interacts with the `BookmarkRepository` to fetch the best favicon URL.
///
/// Example usage:
/// ```dart
/// final fetchBestFaviconUrlUsecase = FetchBestFaviconUrlUsecase(repository: yourFaviconRepository);
///
/// final result = await fetchBestFaviconUrlUsecase.call('https://example.com');
///
/// result.fold(
///   (failure) => print('Error: $failure'),
///   (faviconUrl) => print('Best Favicon URL: $faviconUrl'),
/// );
/// ```
///
/// This example demonstrates how to use the `FetchBestFaviconUrlUsecase` to fetch
/// the best favicon URL for the provided website, handle potential errors, and
/// process the retrieved favicon URL.
class FetchBestFaviconUrlUsecase extends UseCase<String?, String> {
  /// Creates an instance of [FetchBestFaviconUrlUsecase].
  ///
  /// [repository] - The repository used to fetch the best favicon URL.
  FetchBestFaviconUrlUsecase({required this.repository});

  final BookmarkRepository repository;

  /// Fetches the best favicon URL for the specified website.
  ///
  /// This method calls the repository to retrieve the most suitable favicon URL
  /// based on predefined criteria.
  @override
  Future<Either<Failure, String?>> call(String params) async {
    return await repository.fetchBestFaviconUrl(params);
  }
}
