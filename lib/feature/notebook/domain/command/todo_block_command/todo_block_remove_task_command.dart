import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';

class TodoBlockRemoveTaskCommand extends NotebookCommand<TodoBlock> {
  TodoBlockRemoveTaskCommand({
    required this.block,
    required this.taskId,
  });

  final TodoBlock block;
  final num taskId;

  @override
  num? get ownerId => block.id;

  @override
  String getTitle() => "Todo Block: Remove task";

  @override
  NotebookCommandType get type => NotebookCommandType.todo;

  @override
  TodoBlock execute() {
    final updatedItems =
        block.items.where((item) => item.id != taskId).toList();

    return block.copyWith(items: updatedItems);
  }

  @override
  TodoBlock undo() => block;
}
