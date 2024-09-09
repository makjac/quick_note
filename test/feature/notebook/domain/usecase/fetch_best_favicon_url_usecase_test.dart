import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quick_note/core/error/failure/network_failure.dart';
import 'package:quick_note/feature/notebook/domain/repository/bookmarks_repository.dart';
import 'package:quick_note/feature/notebook/domain/usecase/fetch_best_favicon_url_usecase.dart';

class MockBookmarkRepository extends Mock implements BookmarkRepository {}

void main() {
  late FetchBestFaviconUrlUsecase usecase;
  late MockBookmarkRepository mockRepository;

  setUp(() {
    mockRepository = MockBookmarkRepository();
    usecase = FetchBestFaviconUrlUsecase(repository: mockRepository);
  });

  const testUrl = 'https://example.com';
  const expectedFaviconUrl = 'https://example.com/favicon.ico';

  setUpAll(() {
    registerFallbackValue(testUrl);
  });

  group('FetchBestFaviconUrlUsecase', () {
    test(
        'should return the best Favicon URL when the repository call is successful',
        () async {
      // arrange
      when(() => mockRepository.fetchBestFaviconUrl(any()))
          .thenAnswer((_) async => const Right(expectedFaviconUrl));

      // act
      final result = await usecase.call(testUrl);

      // assert
      expect(result, const Right(expectedFaviconUrl));
      verify(() => mockRepository.fetchBestFaviconUrl(testUrl)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return a Failure when the repository call is unsuccessful',
        () async {
      // arrange
      const failure = NetworkFailure();
      when(() => mockRepository.fetchBestFaviconUrl(any()))
          .thenAnswer((_) async => const Left(failure));

      // act
      final result = await usecase.call(testUrl);

      // assert
      expect(result, const Left(failure));
      verify(() => mockRepository.fetchBestFaviconUrl(testUrl)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
