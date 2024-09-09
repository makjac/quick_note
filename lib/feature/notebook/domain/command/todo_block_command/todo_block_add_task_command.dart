import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/check_list_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';

class TodoBlockAddTaskCommand extends NotebookCommand<TodoBlock> {
  TodoBlockAddTaskCommand({required this.block, required this.newTaskItem});

  final TodoBlock block;
  final ChecklistItem newTaskItem;

  @override
  num? get ownerId => block.id;

  @override
  String getTitle() => "Todo Block: Add task";

  @override
  NotebookCommandType get type => NotebookCommandType.todo;

  @override
  TodoBlock execute() {
    final updatedItems = List<ChecklistItem>.from(block.items)
      ..add(newTaskItem);

    return block.copyWith(items: updatedItems);
  }

  @override
  TodoBlock undo() => block;
}
