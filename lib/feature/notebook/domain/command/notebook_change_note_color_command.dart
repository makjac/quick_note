import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_colors.dart';

class NotebookChangeNoteColorCommand extends NotebookCommand<NoteUpdates> {
  NotebookChangeNoteColorCommand({required Note? note, required this.color})
      : previousColor = note?.color ?? NoteColors.color1;

  final NoteColors previousColor;
  final NoteColors color;

  @override
  num? get ownerId => null;

  @override
  String getTitle() => "Change note color";

  @override
  NotebookCommandType get type => NotebookCommandType.global;

  @override
  NoteUpdates execute() {
    return NoteUpdates(color: color);
  }

  @override
  NoteUpdates undo() {
    return NoteUpdates(color: previousColor);
  }
}
