import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quick_note/core/error/failure/network_failure.dart';
import 'package:quick_note/feature/notebook/domain/repository/bookmarks_repository.dart';
import 'package:quick_note/feature/notebook/domain/usecase/is_valid_favicon_url_usecase.dart';

class MockBookmarkRepository extends Mock implements BookmarkRepository {}

void main() {
  late IsValidFaviconUrlUsecase usecase;
  late MockBookmarkRepository mockRepository;

  setUp(() {
    mockRepository = MockBookmarkRepository();
    usecase = IsValidFaviconUrlUsecase(repository: mockRepository);
  });

  const testUrl = 'https://example.com/favicon.ico';
  const isValidFavicon = true;

  setUpAll(() {
    registerFallbackValue(testUrl);
  });

  group('IsValidFaviconUrlUsecase', () {
    test('should return true when the favicon URL is valid', () async {
      // arrange
      when(() => mockRepository.isValidFaviconUrl(any()))
          .thenAnswer((_) async => const Right(isValidFavicon));

      // act
      final result = await usecase.call(testUrl);

      // assert
      expect(result, const Right(isValidFavicon));
      verify(() => mockRepository.isValidFaviconUrl(testUrl)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return a Failure when the repository call is unsuccessful',
        () async {
      // arrange
      const failure = NetworkFailure();
      when(() => mockRepository.isValidFaviconUrl(any()))
          .thenAnswer((_) async => const Left(failure));

      // act
      final result = await usecase.call(testUrl);

      // assert
      expect(result, const Left(failure));
      verify(() => mockRepository.isValidFaviconUrl(testUrl)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
