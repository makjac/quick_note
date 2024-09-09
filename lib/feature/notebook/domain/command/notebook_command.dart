abstract class NotebookCommand<T> {
  num? get ownerId;
  String getTitle();
  NotebookCommandType get type;
  T execute();
  T undo();
}
enum NotebookCommandType {
  global,
  text,
  todo,
  bookmark;
}
