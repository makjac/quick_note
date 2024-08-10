import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/feature/notebook/domain/entity/favicon_data.dart';

abstract class BookmarkRepository {
/// Fetches the best favicon URL for a given bookmark URL.
  ///
  /// Example usage:
  /// ```dart
  /// final result = await bookmarkRepository.fetchBestFaviconUrl('https://example.com');
  /// result.fold(
  ///   (failure) => print('Error: $failure'),
  ///   (faviconUrl) => print('Best favicon URL: $faviconUrl'),
  /// );
  /// ```
  ///
  /// Returns an `Either` with a `Failure` on error or the best favicon URL on success.
  Future<Either<Failure, String?>> fetchBestFaviconUrl(String url);

  /// Fetches all available favicon URLs for a given bookmark URL.
  ///
  /// Example usage:
  /// ```dart
  /// final result = await bookmarkRepository.fetchAllFaviconUrls('https://example.com');
  /// result.fold(
  ///   (failure) => print('Error: $failure'),
  ///   (favicons) => favicons.forEach((favicon) => print('Favicon URL: ${favicon.url}')),
  /// );
  /// ```
  ///
  /// Returns an `Either` with a `Failure` on error or a list of `FaviconDataModel` on success.
  Future<Either<Failure, List<FaviconData>>> fetchAllFaviconUrls(String url);

  /// Fetches favicons of a specific type for a given bookmark URL.
  ///
  /// Example usage:
  /// ```dart
  /// final result = await bookmarkRepository.fetchFaviconsByType('https://example.com', 'image/png');
  /// result.fold(
  ///   (failure) => print('Error: $failure'),
  ///   (favicons) => favicons.forEach((favicon) => print('Favicon URL: ${favicon.url}')),
  /// );
  /// ```
  ///
  /// Returns an `Either` with a `Failure` on error or a list of `FaviconDataModel` on success.
  Future<Either<Failure, List<FaviconData>>> fetchFaviconsByType(
      String url, String type);

  /// Fetches favicons within a specified size range for a given bookmark URL.
  ///
  /// Example usage:
  /// ```dart
  /// final result = await bookmarkRepository.fetchFaviconsBySizeRange('https://example.com', 16, 32);
  /// result.fold(
  ///   (failure) => print('Error: $failure'),
  ///   (favicons) => favicons.forEach((favicon) => print('Favicon URL: ${favicon.url}, Size: ${favicon.sizes}')),
  /// );
  /// ```
  ///
  /// Returns an `Either` with a `Failure` on error or a list of `FaviconDataModel` on success.
  Future<Either<Failure, List<FaviconData>>> fetchFaviconsBySizeRange(
      String url, int minSize, int maxSize);

  /// Checks if a given URL is a valid favicon URL.
  ///
  /// Example usage:
  /// ```dart
  /// final result = await bookmarkRepository.isValidFaviconUrl('https://example.com/favicon.ico');
  /// result.fold(
  ///   (failure) => print('Error: $failure'),
  ///   (isValid) => print('Is valid favicon URL: $isValid'),
  /// );
  /// ```
  ///
  /// Returns an `Either` with a `Failure` on error or a boolean indicating validity on success.
  Future<Either<Failure, bool>> isValidFaviconUrl(String url);

  Future<Either<Failure, List<FaviconData>>> fetchFaviconsByDomain(
      String domain);
}
