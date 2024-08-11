import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quick_note/core/error/failure/network_failure.dart';
import 'package:quick_note/feature/notebook/data/model/favicon_data.module.dart';
import 'package:quick_note/feature/notebook/domain/entity/favicon_data.dart';
import 'package:quick_note/feature/notebook/domain/repository/bookmarks_repository.dart';
import 'package:quick_note/feature/notebook/domain/usecase/fetch_all_favicon_data_usecase.dart';

// Tworzymy klasę mockującą interfejs BookmarkRepository
class MockBookmarkRepository extends Mock implements BookmarkRepository {}

void main() {
  late FetchAllFaviconDataUsecase usecase;
  late MockBookmarkRepository mockRepository;

  setUp(() {
    mockRepository = MockBookmarkRepository();
    usecase = FetchAllFaviconDataUsecase(repository: mockRepository);
  });

  const testUrl = 'https://example.com';
  final List<FaviconData> faviconList = [
    const FaviconDataModel(
        url: 'https://example.com/favicon.ico', sizes: '16x16'),
    const FaviconDataModel(
        url: 'https://example.com/high-res-icon.png', sizes: '32x32')
  ];

  // Rejestracja parametrów, które będą używane w mockowaniu
  setUpAll(() {
    registerFallbackValue(testUrl);
  });

  group('FetchAllFaviconDataUsecase', () {
    test(
        'should return a list of FaviconData when the repository call is successful',
        () async {
      // arrange
      when(() => mockRepository.fetchAllFaviconUrls(any()))
          .thenAnswer((_) async => Right(faviconList));

      // act
      final result = await usecase.call(testUrl);

      // assert
      expect(result, Right(faviconList));
      verify(() => mockRepository.fetchAllFaviconUrls(testUrl)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return a Failure when the repository call is unsuccessful',
        () async {
      // arrange
      const failure = NetworkFailure();
      when(() => mockRepository.fetchAllFaviconUrls(any()))
          .thenAnswer((_) async => const Left(failure));

      // act
      final result = await usecase.call(testUrl);

      // assert
      expect(result, const Left(failure));
      verify(() => mockRepository.fetchAllFaviconUrls(testUrl)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
