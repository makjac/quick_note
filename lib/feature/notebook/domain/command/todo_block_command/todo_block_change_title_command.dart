import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';

class TodoBlockChangeTitleCommand extends NotebookCommand<TodoBlock> {
  TodoBlockChangeTitleCommand({
    required this.block,
    required this.newTitle,
  });

  final TodoBlock block;
  final String newTitle;

  @override
  num? get ownerId => block.id;

  @override
  String getTitle() => "Todo Block: Change title";

  @override
  NotebookCommandType get type => NotebookCommandType.todo;

  @override
  TodoBlock execute() {
    return block.copyWith(title: newTitle);
  }

  @override
  TodoBlock undo() => block;
}
