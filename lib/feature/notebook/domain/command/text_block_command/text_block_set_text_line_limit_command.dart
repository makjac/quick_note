import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';

class TextBlockSetTextLineLimitCommand extends NotebookCommand<TextBlock> {
  TextBlockSetTextLineLimitCommand({
    required this.block,
    required this.newLineLimit,
  });

  final TextBlock block;
  final int newLineLimit;

  @override
  num? get ownerId => block.id;

  @override
  String getTitle() => "Text Block: Set text line limit";

  @override
  NotebookCommandType get type => NotebookCommandType.text;

  @override
  TextBlock execute() {
    return block.copyWith(maxLines: newLineLimit);
  }

  @override
  TextBlock undo() {
    return block;
  }
}
