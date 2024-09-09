import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';

class TodoBlockRenameTaskCommand extends NotebookCommand<TodoBlock> {
  TodoBlockRenameTaskCommand({
    required this.block,
    required this.taskId,
    required this.newTaskName,
  });

  final TodoBlock block;
  final num taskId;
  final String newTaskName;

  @override
  num? get ownerId => block.id;

  @override
  String getTitle() => "Todo Block: Rename task";

  @override
  NotebookCommandType get type => NotebookCommandType.todo;

  @override
  TodoBlock execute() {
    final updatedItems = block.items.map((item) {
      if (item.id == taskId) {
        return item.copyWith(title: newTaskName);
      }
      return item;
    }).toList();

    return block.copyWith(items: updatedItems);
  }

  @override
  TodoBlock undo() => block;
}
