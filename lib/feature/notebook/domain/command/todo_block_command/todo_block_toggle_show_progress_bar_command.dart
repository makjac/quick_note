import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';

class TodoBlockToggleShowProgressBarCommand extends NotebookCommand<TodoBlock> {
  TodoBlockToggleShowProgressBarCommand({
    required this.block,
    required this.isVisible,
  });

  final TodoBlock block;
  final bool isVisible;

  @override
  num? get ownerId => block.id;

  @override
  String getTitle() => "Todo Block: Toggle show progress bar";

  @override
  NotebookCommandType get type => NotebookCommandType.todo;

  @override
  TodoBlock execute() {
    return block.copyWith(showProgressBar: isVisible);
  }

  @override
  TodoBlock undo() => block;
}
