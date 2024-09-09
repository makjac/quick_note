import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';

class TextBlockTitleVisibilityCommand extends NotebookCommand<TextBlock> {
  TextBlockTitleVisibilityCommand({
    required this.block,
    required this.newTitleVisibility,
  });

  final TextBlock block;
  final bool newTitleVisibility;

  @override
  num? get ownerId => block.id;

  @override
  String getTitle() => "Text Block: Change title visibility";

  @override
  NotebookCommandType get type => NotebookCommandType.text;

  @override
  TextBlock execute() {
    return block.copyWith(hasTitle: newTitleVisibility);
  }

  @override
  TextBlock undo() {
    return block;
  }
}
