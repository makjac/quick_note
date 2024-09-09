/// An abstract class that represents a command to be executed on a notebook.
///
/// Each command encapsulates an operation that affects the notebook in some way,
/// such as modifying text, adding a to-do item, or bookmarking a section. Commands
/// are designed to be both executed and undone, allowing changes to be easily reverted.
///
/// The generic type parameter [T] represents the type of the result returned by the
/// command's execution and undo operations (e.g., updates to the notebook).
abstract class NotebookCommand<T> {
  /// The identifier of the owner of the command (e.g., the note or notebook
  /// that the command is applied to).
  ///
  /// This is an optional property and may be `null` if the command does not
  /// have an associated owner.
  num? get ownerId;

  /// Returns the title or description of the command.
  ///
  /// This can be used to display a user-friendly name for the command in a UI,
  /// for example, in undo/redo histories.
  String getTitle();

  /// The type of the command, which indicates the category or purpose of the
  /// operation (e.g., modifying text, adding a to-do item).
  ///
  /// This property helps to classify and distinguish between different types of
  /// notebook commands.
  NotebookCommandType get type;

  /// Executes the command, applying the desired changes to the notebook.
  ///
  /// This method performs the operation that the command encapsulates, such as
  /// adding or modifying a block of content in the notebook.
  ///
  /// Returns an instance of type [T], which typically represents updates or
  /// changes made to the notebook as a result of the execution.
  T execute();

  /// Undoes the command, reverting the changes made by the most recent execution.
  ///
  /// This method restores the notebook to the state it was in before the command
  /// was executed. It allows for the operation to be undone, providing support
  /// for undo functionality.
  ///
  /// Returns an instance of type [T], which represents the changes applied to
  /// revert the command.
  T undo();
}
enum NotebookCommandType {
  global,
  text,
  todo,
  bookmark;
}
