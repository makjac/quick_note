import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';

class TextBlockChangeNoteTextCommand extends NotebookCommand<TextBlock> {
  TextBlockChangeNoteTextCommand({
    required this.block,
    required this.newNoteText,
  });

  final TextBlock block;
  final String newNoteText;

  @override
  num? get ownerId => block.id;

  @override
  String getTitle() => "Text Block: Change note text";

  @override
  NotebookCommandType get type => NotebookCommandType.text;

  @override
  TextBlock execute() {
    return block.copyWith(text: newNoteText);
  }

  @override
  TextBlock undo() {
    return block;
  }
}
