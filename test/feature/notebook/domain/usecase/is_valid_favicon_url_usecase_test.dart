import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quick_note/core/error/failure/network_failure.dart';
import 'package:quick_note/feature/notebook/domain/repository/bookmarks_repository.dart';
import 'package:quick_note/feature/notebook/domain/usecase/is_valid_favicon_url_usecase.dart';

// Tworzymy klasę mockującą interfejs BookmarkRepository
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

  // Rejestracja parametrów, które będą używane w mockowaniu
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
  });
}
