import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';

class NotebookRemoveNoteBlockCommand extends NotebookCommand<NoteUpdates> {
  NotebookRemoveNoteBlockCommand({required Note? note, required this.blockId})
      : previousContent = note?.content ?? [];

  final List<NoteBlock> previousContent;
  final num blockId;

  @override
  num? get ownerId => null;

  @override
  String getTitle() => "Remove note block";

  @override
  NotebookCommandType get type => NotebookCommandType.global;

  @override
  NoteUpdates execute() {
    final content =
        previousContent.where((block) => block.id != blockId).toList();
    return NoteUpdates(content: content);
  }

  @override
  NoteUpdates undo() {
    return NoteUpdates(content: previousContent);
  }
}
