import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/notebook/domain/command/todo_block_command/todo_block_toggle_show_progress_bar_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';

void main() {
  group('TodoBlockToggleShowProgressBarCommand', () {
    late TodoBlock block;
    late TodoBlockToggleShowProgressBarCommand command;

    setUp(() {
      block = const TodoBlock(id: 1, showProgressBar: false, items: []);
      command =
          TodoBlockToggleShowProgressBarCommand(block: block, isVisible: true);
    });

    test('should return correct ownerId', () {
      expect(command.ownerId, block.id);
    });

    test('should return correct title', () {
      expect(command.getTitle(), "Todo Block: Toggle show progress bar");
    });

    test('should return correct type', () {
      expect(command.type, NotebookCommandType.todo);
    });

    test('should execute command and toggle showProgressBar', () {
      final updatedBlock = command.execute();
      expect(updatedBlock.showProgressBar, true);
    });

    test('should undo command and return original block', () {
      final originalBlock = command.undo();
      expect(originalBlock, block);
    });
  });
}
