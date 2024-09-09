import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/presentation/cubit/todo_block_cubit/todo_block_cubit.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/check_list_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';

void main() {
  group('TodoBlockState', () {
    test('initial state is TodoBlockInitial', () {
      final state = TodoBlockInitial();
      expect(state, isA<TodoBlockInitial>());
    });

    test('copyWith returns a new instance with updated block', () {
      const oldBlock =
          TodoBlock(id: 1, items: [ChecklistItem(id: 1, title: 'Test')]);
      const newBlock =
          TodoBlock(id: 2, items: [ChecklistItem(id: 2, title: 'New Test')]);

      const oldState = TodoBlockState(block: oldBlock);
      final newState = oldState.copyWith(block: newBlock);

      expect(newState.block, newBlock);
      expect(newState.block, isNot(equals(oldBlock)));
    });

    test('copyWith returns a new instance with the same block if not provided',
        () {
      const block =
          TodoBlock(id: 1, items: [ChecklistItem(id: 1, title: 'Test')]);
      const state = TodoBlockState(block: block);
      final newState = state.copyWith();

      expect(newState.block, block);
      expect(newState, equals(state));
    });

    test('TodoBlockAddedNewTaskItem creates a new state with added item', () {
      const block = TodoBlock(id: 1, items: []);
      const state = TodoBlockState(block: block);
      const item = ChecklistItem(id: 1, title: 'New Task');

      final newState = TodoBlockAddedNewTaskItem.fromState(state, item);

      expect(newState.block, block);
      expect(newState.item, item);
    });

    test('TodoBlockUndoRedoState creates a new state from existing state', () {
      const block = TodoBlock(id: 1, items: []);
      const state = TodoBlockState(block: block);

      final newState = TodoBlockUndoRedoState.fromState(state);

      expect(newState.block, block);
    });
  });
}
