import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

class NotebookToggleArchiveCommand extends NotebookCommand<NoteUpdates> {
  NotebookToggleArchiveCommand({required Note? note})
      : previousArchived = note?.archived ?? false;

  final bool previousArchived;

  @override
  num? get ownerId => null;

  @override
  String getTitle() => "Toggle note archive";

  @override
  NotebookCommandType get type => NotebookCommandType.global;

  @override
  NoteUpdates execute() {
    return NoteUpdates(archived: !previousArchived);
  }

  @override
  NoteUpdates undo() {
    return NoteUpdates(archived: previousArchived);
  }
}
