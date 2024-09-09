import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/presentation/cubit/bookmarks_block_cubit/bookmarks_block_cubit.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';

void main() {
  group('BookmarksBlockState', () {
    test('should have correct initial values when no arguments are provided',
        () {
      const state = BookmarksBlockState();

      expect(state.block, const BookmarksBlock(id: -1));
      expect(state.addingStatus, AddBookmarkStatus.none);
    });

    test('should allow setting custom values through constructor', () {
      const customBlock = BookmarksBlock(id: 1);
      const customStatus = AddBookmarkStatus.loading;

      const state = BookmarksBlockState(
        block: customBlock,
        addingStatus: customStatus,
      );

      expect(state.block, customBlock);
      expect(state.addingStatus, customStatus);
    });

    test('copyWith should create a new state with updated values', () {
      const initialState = BookmarksBlockState();

      const updatedBlock = BookmarksBlock(id: 2);
      const updatedStatus = AddBookmarkStatus.success;

      final newState = initialState.copyWith(
        block: updatedBlock,
        addingStatus: updatedStatus,
      );

      expect(newState.block, updatedBlock);
      expect(newState.addingStatus, updatedStatus);

      expect(initialState.block, const BookmarksBlock(id: -1));
      expect(initialState.addingStatus, AddBookmarkStatus.none);
    });

    test(
        'copyWith should return a new state with the same values if no arguments are provided',
        () {
      const initialState = BookmarksBlockState();

      final newState = initialState.copyWith();

      expect(newState.block, initialState.block);
      expect(newState.addingStatus, initialState.addingStatus);
    });

    test('BookmarksBlockState should be equatable based on its properties', () {
      const state1 = BookmarksBlockState();
      const state2 = BookmarksBlockState();

      expect(state1, state2);

      const updatedBlock = BookmarksBlock(id: 2);
      const state3 = BookmarksBlockState(block: updatedBlock);

      expect(state1, isNot(state3));
    });
  });

  group('BookmarksBlockUndoRedoState', () {
    test('should create a new state from an existing state', () {
      const initialState = BookmarksBlockState(
        block: BookmarksBlock(id: 1),
        addingStatus: AddBookmarkStatus.none,
      );

      final undoRedoState = BookmarksBlockUndoRedoState.fromState(initialState);

      expect(undoRedoState.block, initialState.block);
      expect(undoRedoState.addingStatus, initialState.addingStatus);
    });

    test('should be equatable based on its properties', () {
      const state1 = BookmarksBlockUndoRedoState(block: BookmarksBlock(id: 1));
      const state2 = BookmarksBlockUndoRedoState(block: BookmarksBlock(id: 1));

      expect(state1, state2);

      const state3 = BookmarksBlockUndoRedoState(block: BookmarksBlock(id: 2));

      expect(state1, isNot(state3));
    });
  });
}
