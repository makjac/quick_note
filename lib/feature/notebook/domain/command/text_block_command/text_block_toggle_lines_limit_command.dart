import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';

class TextBlockToggleLinesLimitCommand extends NotebookCommand<TextBlock> {
  TextBlockToggleLinesLimitCommand({
    required this.block,
    required this.newHasLinesLimit,
  });

  final TextBlock block;
  final bool newHasLinesLimit;

  @override
  num? get ownerId => block.id;

  @override
  String getTitle() => "Text Block: Toggle lines limit";

  @override
  NotebookCommandType get type => NotebookCommandType.text;

  @override
  TextBlock execute() {
    return block.copyWith(hasMaxLineLimit: newHasLinesLimit);
  }

  @override
  TextBlock undo() {
    return block;
  }
}
