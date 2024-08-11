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

      // Ensure the original state has not changed
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
}
