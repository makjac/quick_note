import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';

class NotebookAddNoteBlockCommand extends NotebookCommand<NoteUpdates> {
  NotebookAddNoteBlockCommand({required Note? note, required this.noteBlock})
      : previousContent = note?.content ?? const [];

  final List<NoteBlock> previousContent;
  final NoteBlock noteBlock;

  @override
  num? get ownerId => null;

  @override
  String getTitle() => "Add note block";

  @override
  NotebookCommandType get type => NotebookCommandType.global;

  @override
  NoteUpdates execute() {
    return NoteUpdates(content: [...previousContent, noteBlock]);
  }

  @override
  NoteUpdates undo() {
    return NoteUpdates(content: previousContent);
  }
}
