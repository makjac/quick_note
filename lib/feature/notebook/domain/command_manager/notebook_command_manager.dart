import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';

/// An interface for managing commands related to notebook operations, such as
/// adding, removing, or modifying blocks within a note. This interface
/// provides methods to execute commands, as well as to undo and redo changes.
abstract class NotebookCommandManager {
  /// Retrieves the type of the most recent command on the undo stack, if available.
  ///
  /// Returns the [NotebookCommandType] of the last executed command that can be undone,
  /// or `null` if there are no commands on the undo stack.
  NotebookCommandType? get getCurrentUndoType;

  /// Retrieves the type of the most recent command on the redo stack, if available.
  ///
  /// Returns the [NotebookCommandType] of the last undone command that can be redone,
  /// or `null` if there are no commands on the redo stack.
  NotebookCommandType? get getCurrentRedoType;

  /// Executes a given command that affects the notebook.
  ///
  /// This method applies the command's changes to the notebook and adds the
  /// command to the undo stack, allowing it to be undone later if needed.
  ///
  /// [command] The command to be executed, which encapsulates the operation
  /// to be performed on the notebook.
  ///
  /// Returns [NoteUpdates] reflecting the changes made to the notebook.
  NoteUpdates execute(NotebookCommand command);

  /// Undoes the last executed command.
  ///
  /// This method reverts the changes made by the most recent command by
  /// invoking its `undo` method. The undone command is then moved to the
  /// redo stack, making it possible to redo the command later if needed.
  /// If there are no commands to undo, this method does nothing.
  ///
  /// Returns [NoteUpdates] if a command was undone, or `null` if no commands are available to undo.
  NoteUpdates? undo();

  /// Redoes the last undone command.
  ///
  /// This method reapplies the changes made by the most recent undone command
  /// by invoking its `execute` method again. The redone command is then moved
  /// back to the undo stack, allowing it to be undone again if needed.
  /// If there are no commands to redo, this method does nothing.
  ///
  /// Returns [NoteUpdates] if a command was redone, or `null` if no commands are available to redo.
  NoteUpdates? redo();

  /// Adds a command to the undo stack.
  ///
  /// This method pushes the given [command] to the undo stack, clearing the redo stack
  /// in the process to ensure redo operations reflect the current state.
  ///
  /// [command] The command to be added to the undo stack.
  void pushToUndoStack(NotebookCommand command);

  /// Adds a command to the redo stack.
  ///
  /// This method pushes the given [command] to the redo stack, allowing it to
  /// be redone if the user wishes to revert the undo operation.
  ///
  /// [command] The command to be added to the redo stack.
  void pushToRedoStack(NotebookCommand command);

  /// Removes and returns the last command from the undo stack.
  ///
  /// This method pops the most recent command from the undo stack, moving it
  /// to the redo stack, so the operation can be undone.
  ///
  /// Returns the last [NotebookCommand] from the undo stack, or `null` if the stack is empty.
  NotebookCommand? popUndoStack();

  /// Removes and returns the last command from the redo stack.
  ///
  /// This method pops the most recent command from the redo stack, moving it
  /// to the undo stack, so the operation can be redone.
  ///
  /// Returns the last [NotebookCommand] from the redo stack, or `null` if the stack is empty.
  NotebookCommand? popRedoStack();

  /// Clears the undo and redo stacks.
  ///
  /// This method empties both the undo and redo stacks, resetting the history
  /// of commands that can be undone or redone.
  void clear();
}

/// A concrete implementation of [NotebookCommandManager] that maintains
/// stacks for undoing and redoing operations on a notebook. This class
/// manages the history of commands to support undo and redo functionality
/// for operations such as adding or removing blocks from a note.
///
/// It uses two stacks: one for undoing operations (`_undoStack`) and one for
/// redoing operations (`_redoStack`). The stacks help in keeping track of
/// commands that have been executed and those that have been undone.
class NotebookCommandManagerImpl implements NotebookCommandManager {
  final List<NotebookCommand> _undoStack = [];
  final List<NotebookCommand> _redoStack = [];

  @override
  NotebookCommandType? get getCurrentUndoType =>
      _undoStack.isNotEmpty ? _undoStack.last.type : null;

  @override
  NotebookCommandType? get getCurrentRedoType =>
      _redoStack.isNotEmpty ? _redoStack.last.type : null;

  @override
  NoteUpdates execute(NotebookCommand command) {
    _undoStack.add(command);
    _redoStack.clear();
    return command.execute();
  }

  @override
  NoteUpdates? undo() {
    if (_undoStack.isEmpty) return null;

    final command = _undoStack.removeLast();
    _redoStack.add(command);
    return command.undo();
  }

  @override
  NoteUpdates? redo() {
    if (_redoStack.isEmpty) return null;

    final command = _redoStack.removeLast();
    _undoStack.add(command);
    return command.execute();
  }

  @override
  void pushToUndoStack(NotebookCommand command) {
    _undoStack.add(command);
    _redoStack.clear();
  }

  @override
  void pushToRedoStack(NotebookCommand command) {
    _redoStack.add(command);
  }

  @override
  NotebookCommand? popUndoStack() {
    if (_undoStack.isEmpty) return null;

    final command = _undoStack.removeLast();
    _redoStack.add(command);
    return command;
  }

  @override
  NotebookCommand? popRedoStack() {
    if (_redoStack.isEmpty) return null;

    final command = _redoStack.removeLast();
    _undoStack.add(command);
    return command;
  }

  @override
  void clear() {
    _undoStack.clear();
    _redoStack.clear();
  }
}
