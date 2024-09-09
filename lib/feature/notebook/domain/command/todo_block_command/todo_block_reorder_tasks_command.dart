import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/check_list_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';

class TodoBlockReorderTasksCommand extends NotebookCommand<TodoBlock> {
  TodoBlockReorderTasksCommand({
    required this.block,
    required this.oldIndex,
    required this.newIndex,
  });

  final TodoBlock block;
  final int oldIndex;
  final int newIndex;

  @override
  num? get ownerId => block.id;

  @override
  String getTitle() => "Todo Block: Reorder tasks";

  @override
  NotebookCommandType get type => NotebookCommandType.todo;

  @override
  TodoBlock execute() {
    if (oldIndex < 0 ||
        oldIndex >= block.items.length ||
        newIndex < 0 ||
        newIndex >= block.items.length) {
      return block;
    }

    final updatedItems = List<ChecklistItem>.from(block.items);
    final item = updatedItems.removeAt(oldIndex);
    updatedItems.insert(newIndex, item);

    return block.copyWith(items: updatedItems);
  }

  @override
  TodoBlock undo() => block;
}
