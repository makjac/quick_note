import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

class NotebookToggleNoteStarCommand extends NotebookCommand<NoteUpdates> {
  NotebookToggleNoteStarCommand({required Note? note})
      : previousIsStarred = note?.isStarred ?? false;

  final bool previousIsStarred;

  @override
  num? get ownerId => null;

  @override
  String getTitle() => "Toggle note star";

  @override
  NotebookCommandType get type => NotebookCommandType.global;

  @override
  NoteUpdates execute() {
    return NoteUpdates(isStarred: !previousIsStarred);
  }

  @override
  NoteUpdates undo() {
    return NoteUpdates(isStarred: previousIsStarred);
  }
}
