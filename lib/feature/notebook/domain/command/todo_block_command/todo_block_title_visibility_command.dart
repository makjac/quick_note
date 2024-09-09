import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';

class TodoBlockTitleVisibilityCommand extends NotebookCommand<TodoBlock> {
  TodoBlockTitleVisibilityCommand({
    required this.block,
    required this.isVisible,
  });

  final TodoBlock block;
  final bool isVisible;

  @override
  num? get ownerId => block.id;

  @override
  String getTitle() => "Todo Block: Change title visibility";

  @override
  NotebookCommandType get type => NotebookCommandType.todo;

  @override
  TodoBlock execute() {
    return block.copyWith(hasTitle: isVisible);
  }

  @override
  TodoBlock undo() => block;
}
