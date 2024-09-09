abstract class NotebookCommand<T> {
  num? get ownerId;
  String getTitle();
  NotebookCommandType get type;
  T execute();
  T undo();
}
