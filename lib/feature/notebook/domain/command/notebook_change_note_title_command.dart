import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

class NotebookChangeNoteTitleCommand extends NotebookCommand<NoteUpdates> {
  NotebookChangeNoteTitleCommand({Note? note, required this.newTitle})
      : previousTitle = note?.title ?? "";

  final String previousTitle;
  final String newTitle;

  @override
  num? get ownerId => null;

  @override
  String getTitle() => "Change note title";

  @override
  NotebookCommandType get type => NotebookCommandType.global;

  @override
  NoteUpdates execute() {
    return NoteUpdates(title: newTitle);
  }

  @override
  NoteUpdates undo() {
    return NoteUpdates(title: previousTitle);
  }
}
