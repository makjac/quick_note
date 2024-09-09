import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';

class TodoBlockToggleTaskCommand extends NotebookCommand<TodoBlock> {
  TodoBlockToggleTaskCommand({
    required this.block,
    required this.taskId,
  });

  final TodoBlock block;
  final num taskId;

  @override
  num? get ownerId => block.id;

  @override
  String getTitle() => "Todo Block: Toggle task";

  @override
  NotebookCommandType get type => NotebookCommandType.todo;

  @override
  TodoBlock execute() {
    final updatedItems = block.items.map((item) {
      if (item.id == taskId) {
        return item.copyWith(isChecked: !item.isChecked);
      }
      return item;
    }).toList();

    return block.copyWith(items: updatedItems);
  }

  @override
  TodoBlock undo() => block;
}
