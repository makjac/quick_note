import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/home/presentation/cubit/note_search_cubit.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('NoteSearchCubit', () {
    test('initial state should be NoteSearchInitial', () {
      // Arrange
      final cubit = NoteSearchCubit();

      // Act & Assert
      expect(cubit.state, isA<NoteSearchInitial>());
    });

    blocTest<NoteSearchCubit, NoteSearchState>(
      'should emit NoteSearchState with the new search term when setSearchTerm is called',
      build: () => NoteSearchCubit(),
      act: (cubit) => cubit.setSearchTerm('new search term'),
      expect: () => [
        isA<NoteSearchState>().having(
            (state) => state.searchTerm, 'searchTerm', 'new search term'),
      ],
    );

    blocTest<NoteSearchCubit, NoteSearchState>(
      'should emit NoteSearchState with an empty search term when clearSearchTerm is called',
      build: () => NoteSearchCubit(),
      act: (cubit) => cubit.clearSearchTerm(),
      expect: () => [
        const NoteSearchState(searchTerm: ''),
      ],
    );
  });
}
