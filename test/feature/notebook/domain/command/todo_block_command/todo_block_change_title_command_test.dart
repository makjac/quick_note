import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/notebook/domain/command/todo_block_command/todo_block_change_title_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';

void main() {
  group('TodoBlockChangeTitleCommand', () {
    late TodoBlock initialBlock;
    late TodoBlockChangeTitleCommand command;

    setUp(() {
      initialBlock = const TodoBlock(id: 1, title: 'Initial Title', items: []);
      command = TodoBlockChangeTitleCommand(
          block: initialBlock, newTitle: 'New Title');
    });

    test('should have correct ownerId', () {
      expect(command.ownerId, initialBlock.id);
    });

    test('should return correct title', () {
      expect(command.getTitle(), "Todo Block: Change title");
    });

    test('should have correct type', () {
      expect(command.type, NotebookCommandType.todo);
    });

    test('should change the title of the block when executed', () {
      final updatedBlock = command.execute();
      expect(updatedBlock.title, 'New Title');
    });

    test('should return the original block when undo is called', () {
      final undoneBlock = command.undo();
      expect(undoneBlock.title, 'Initial Title');
    });
  });
}
