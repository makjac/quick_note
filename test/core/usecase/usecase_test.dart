import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/usecase/usecase.dart';

class _MockUseCase extends UseCase<String, NoParams> {
  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return const Right('Success');
  }
}

void main() {
  group('UseCase', () {
    test('UseCase call should return a success response', () async {
      final useCase = _MockUseCase();
      final result = await useCase(NoParams());

      expect(result, const Right('Success'));
    });
  });
}
