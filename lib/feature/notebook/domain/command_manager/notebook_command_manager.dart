import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';

abstract class NotebookCommandManager {
  NotebookCommandType? get getCurrentUndoType;
  NotebookCommandType? get getCurrentRedoType;
  NoteUpdates execute(NotebookCommand command);
  NoteUpdates? undo();
  NoteUpdates? redo();
  void pushToUndoStack(NotebookCommand command);
  void pushToRedoStack(NotebookCommand command);
  NotebookCommand? popUndoStack();
  NotebookCommand? popRedoStack();
  void clear();
}
class NotebookCommandManagerImpl implements NotebookCommandManager {
  final List<NotebookCommand> _undoStack = [];
  final List<NotebookCommand> _redoStack = [];

  @override
  NotebookCommandType? get getCurrentUndoType =>
      _undoStack.isNotEmpty ? _undoStack.last.type : null;
}
