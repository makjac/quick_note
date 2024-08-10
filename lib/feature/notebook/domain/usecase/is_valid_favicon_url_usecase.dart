import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/usecase/usecase.dart';
import 'package:quick_note/feature/notebook/domain/repository/bookmarks_repository.dart';

/// Use case for validating whether a given favicon URL is valid.
///
/// This use case checks if the provided URL is a valid favicon by verifying
/// its existence and confirming that it is an image file. It interacts with
/// the `BookmarkRepository` to perform this validation.
///
/// Example usage:
/// ```dart
/// final isValidFaviconUrlUsecase = IsValidFaviconUrlUsecase(repository: yourFaviconRepository);
///
/// final result = await isValidFaviconUrlUsecase.call('https://example.com/favicon.ico');
///
/// result.fold(
///   (failure) => print('Error: $failure'),
///   (isValid) => print('Is the favicon URL valid? $isValid'),
/// );
/// ```
///
/// This example demonstrates how to use the `IsValidFaviconUrlUsecase` to check
/// if a specific favicon URL is valid, handle potential errors, and process the
/// result indicating whether the favicon URL is valid or not.
class IsValidFaviconUrlUsecase extends UseCase<bool, String> {
  /// Creates an instance of [IsValidFaviconUrlUsecase].
  ///
  /// [repository] - The repository used to validate the favicon URL.
  IsValidFaviconUrlUsecase({required this.repository});

  final BookmarkRepository repository;

  /// Validates if the provided favicon URL is a valid image.
  ///
  /// This method calls the repository to check if the URL points to a valid favicon
  /// by verifying its existence and ensuring it is an image file.
  @override
  Future<Either<Failure, bool>> call(String params) async {
    return await repository.isValidFaviconUrl(params);
  }
}
