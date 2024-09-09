import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';

class TextBlockChangeTitleCommand extends NotebookCommand<TextBlock> {
  TextBlockChangeTitleCommand({
    required this.block,
    required this.newTitle,
  });

  final TextBlock block;
  final String newTitle;

  @override
  num? get ownerId => block.id;

  @override
  String getTitle() => "Text Block: Change title";

  @override
  NotebookCommandType get type => NotebookCommandType.text;

  @override
  TextBlock execute() {
    return block.copyWith(title: newTitle);
  }

  @override
  TextBlock undo() {
    return block;
  }
}
