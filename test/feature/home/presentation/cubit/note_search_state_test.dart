import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/home/presentation/cubit/note_search_cubit.dart';

void main() {
  group('NoteSearchState', () {
    test('should have the initial state with an empty searchTerm', () {
      // Arrange
      final state = NoteSearchInitial();

      // Act
      final searchTerm = state.searchTerm;

      // Assert
      expect(searchTerm, "");
    });

    test('should be able to create a NoteSearchState with a given searchTerm',
        () {
      // Arrange
      const searchTerm = "test";

      // Act
      const state = NoteSearchState(searchTerm: searchTerm);

      // Assert
      expect(state.searchTerm, searchTerm);
    });

    test(
        'should have equality for different instances with the same searchTerm',
        () {
      // Arrange
      const state1 = NoteSearchState(searchTerm: "test");
      const state2 = NoteSearchState(searchTerm: "test");

      // Act & Assert
      expect(state1, equals(state2));
    });

    test('should not be equal to another state with a different searchTerm',
        () {
      // Arrange
      const state1 = NoteSearchState(searchTerm: "test1");
      const state2 = NoteSearchState(searchTerm: "test2");

      // Act & Assert
      expect(state1, isNot(equals(state2)));
    });

    test('should have the same props for the same searchTerm', () {
      // Arrange
      const state1 = NoteSearchState(searchTerm: "test");
      const state2 = NoteSearchState(searchTerm: "test");

      // Act & Assert
      expect(state1.props, equals(state2.props));
    });

    test('should not have the same props for different searchTerms', () {
      // Arrange
      const state1 = NoteSearchState(searchTerm: "test1");
      const state2 = NoteSearchState(searchTerm: "test2");

      // Act & Assert
      expect(state1.props, isNot(equals(state2.props)));
    });
  });
}
