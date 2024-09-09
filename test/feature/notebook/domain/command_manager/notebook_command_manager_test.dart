import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/notebook/domain/command_manager/notebook_command_manager.dart';

class MockCommand extends NotebookCommand<NoteUpdates> {
  MockCommand(this.commandType, this.executeResult, this.undoResult);

  final NotebookCommandType commandType;
  final NoteUpdates executeResult;
  final NoteUpdates undoResult;

  @override
  num? get ownerId => null;

  @override
  String getTitle() => 'Mock Command';

  @override
  NotebookCommandType get type => commandType;

  @override
  NoteUpdates execute() => executeResult;

  @override
  NoteUpdates undo() => undoResult;
}

void main() {
  group('NotebookCommandManagerImpl Tests', () {
    late NotebookCommandManagerImpl manager;
    late MockCommand command1;
    late MockCommand command2;

    setUp(() {
      manager = NotebookCommandManagerImpl();

      command1 = MockCommand(
        NotebookCommandType.text,
        const NoteUpdates(title: 'Title 1'),
        const NoteUpdates(title: 'Title 0'),
      );

      command2 = MockCommand(
        NotebookCommandType.todo,
        const NoteUpdates(title: 'Title 2'),
        const NoteUpdates(title: 'Title 1'),
      );
    });

    test('should execute a command and clear redo stack', () {
      final result = manager.execute(command1);

      expect(result.title, 'Title 1');
      expect(manager.getCurrentUndoType, NotebookCommandType.text);
      expect(manager.getCurrentRedoType, isNull);
    });

    test('should undo the last command and push it to redo stack', () {
      manager.execute(command1);

      final result = manager.undo();

      expect(result?.title, 'Title 0');
      expect(manager.getCurrentUndoType, isNull);
      expect(manager.getCurrentRedoType, NotebookCommandType.text);
    });

    test('should redo the last undone command and push it back to undo stack',
        () {
      manager.execute(command1);
      manager.undo();

      final result = manager.redo();

      expect(result?.title, 'Title 1');
      expect(manager.getCurrentUndoType, NotebookCommandType.text);
      expect(manager.getCurrentRedoType, isNull);
    });

    test('should clear both undo and redo stacks', () {
      manager.execute(command1);
      manager.execute(command2);
      manager.undo();
      manager.redo();

      manager.clear();

      expect(manager.popUndoStack(), isNull);
      expect(manager.popRedoStack(), isNull);
    });
  });
}
