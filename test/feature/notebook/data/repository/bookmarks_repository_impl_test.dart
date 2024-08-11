import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quick_note/core/error/failure/network_failure.dart';
import 'package:quick_note/core/error/failure/validation_failure.dart';
import 'package:quick_note/feature/notebook/data/datasource/bookmarks_remote_datasource.dart';
import 'package:quick_note/feature/notebook/data/model/favicon_data.module.dart';
import 'package:quick_note/feature/notebook/data/repository/bookmarks_repository_impl.dart';

import 'bookmarks_repository_impl_test.mocks.dart';

@GenerateMocks([BookmarksRemoteDatasource])
void main() {
  late MockBookmarksRemoteDatasource mockDatasource;
  late BookmarkRepositoryImpl repository;

  setUp(() {
    mockDatasource = MockBookmarksRemoteDatasource();
    repository = BookmarkRepositoryImpl(datasource: mockDatasource);
  });

  group('BookmarkRepositoryImpl', () {
    test('fetchBestFaviconUrl returns the URL of the best favicon', () async {
      const testUrl = 'https://example.com';
      const expectedUrl = 'https://example.com/favicon.ico';

      when(mockDatasource.fetchBestFaviconUrl(testUrl))
          .thenAnswer((_) async => expectedUrl);

      final result = await repository.fetchBestFaviconUrl(testUrl);

      expect(result, const Right(expectedUrl));
      verify(mockDatasource.fetchBestFaviconUrl(testUrl));
      verifyNoMoreInteractions(mockDatasource);
    });

    test('fetchAllFaviconUrls returns a list of favicons', () async {
      const testUrl = 'https://example.com';
      final List<FaviconDataModel> faviconList = [
        const FaviconDataModel(
            url: 'https://example.com/favicon.ico', sizes: '16x16'),
        const FaviconDataModel(
            url: 'https://example.com/high-res-icon.png', sizes: '32x32')
      ];

      when(mockDatasource.fetchAllFaviconUrls(testUrl))
          .thenAnswer((_) async => faviconList);

      final result = await repository.fetchAllFaviconUrls(testUrl);

      expect(result, Right(faviconList));
      verify(mockDatasource.fetchAllFaviconUrls(testUrl));
      verifyNoMoreInteractions(mockDatasource);
    });

    test('Test fetchFaviconsByType with Comparable implementation', () async {
      const testUrl = 'https://example.com';
      const testType = 'image/png';

      final List<FaviconDataModel> faviconList = [
        const FaviconDataModel(
            url: 'https://example.com/favicon.ico', sizes: '16x16'),
        const FaviconDataModel(
            url: 'https://example.com/high-res-icon.png', sizes: '32x32')
      ];

      when(mockDatasource.fetchFaviconsByType(testUrl, testType))
          .thenAnswer((_) async => faviconList);

      final result = await repository.fetchFaviconsByType(testUrl, testType);

      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Expected Right but got Left'),
        (list) {
          list.sort(); // Sortowanie zgodnie z Comparable
          expect(
            list,
            equals([
              const FaviconDataModel(
                  url: 'https://example.com/high-res-icon.png', sizes: '32x32'),
              const FaviconDataModel(
                  url: 'https://example.com/favicon.ico', sizes: '16x16'),
            ]),
          );
        },
      );
    });

    test('isValidFaviconUrl returns true for a valid favicon URL', () async {
      const testUrl = 'https://example.com/favicon.ico';
      const isValid = true;

      when(mockDatasource.isValidFaviconUrl(testUrl))
          .thenAnswer((_) async => isValid);

      final result = await repository.isValidFaviconUrl(testUrl);

      expect(result, const Right(isValid));
      verify(mockDatasource.isValidFaviconUrl(testUrl));
      verifyNoMoreInteractions(mockDatasource);
    });

    test('fetchBestFaviconUrl returns NetworkFailure on exception', () async {
      const testUrl = 'https://example.com';

      when(mockDatasource.fetchBestFaviconUrl(testUrl)).thenThrow(Exception());

      final result = await repository.fetchBestFaviconUrl(testUrl);

      expect(result, const Left(NetworkFailure()));
      verify(mockDatasource.fetchBestFaviconUrl(testUrl));
      verifyNoMoreInteractions(mockDatasource);
    });

    test('fetchAllFaviconUrls returns NetworkFailure on exception', () async {
      const testUrl = 'https://example.com';

      when(mockDatasource.fetchAllFaviconUrls(testUrl)).thenThrow(Exception());

      final result = await repository.fetchAllFaviconUrls(testUrl);

      expect(result, const Left(NetworkFailure()));
      verify(mockDatasource.fetchAllFaviconUrls(testUrl));
      verifyNoMoreInteractions(mockDatasource);
    });

    test('fetchFaviconsBySizeRange returns ValidationFailure on exception',
        () async {
      const testUrl = 'https://example.com';
      const minSize = 16;
      const maxSize = 32;

      when(mockDatasource.fetchFaviconsBySizeRange(testUrl, minSize, maxSize))
          .thenThrow(Exception());

      final result =
          await repository.fetchFaviconsBySizeRange(testUrl, minSize, maxSize);

      expect(result, const Left(ValidationFailure()));
      verify(
          mockDatasource.fetchFaviconsBySizeRange(testUrl, minSize, maxSize));
      verifyNoMoreInteractions(mockDatasource);
    });

    test('isValidFaviconUrl returns NetworkFailure on exception', () async {
      const testUrl = 'https://example.com/favicon.ico';

      when(mockDatasource.isValidFaviconUrl(testUrl)).thenThrow(Exception());

      final result = await repository.isValidFaviconUrl(testUrl);

      expect(result, const Left(NetworkFailure()));
      verify(mockDatasource.isValidFaviconUrl(testUrl));
      verifyNoMoreInteractions(mockDatasource);
    });

    test('fetchFaviconsByDomain returns NetworkFailure on exception', () async {
      const domain = 'example.com';

      when(mockDatasource.fetchFaviconsByDomain(domain)).thenThrow(Exception());

      final result = await repository.fetchFaviconsByDomain(domain);

      expect(result, const Left(NetworkFailure()));
      verify(mockDatasource.fetchFaviconsByDomain(domain));
      verifyNoMoreInteractions(mockDatasource);
    });
  });
}
