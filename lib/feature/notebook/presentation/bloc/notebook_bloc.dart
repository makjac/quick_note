import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quick_note/feature/home/domain/usecase/create_note_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/delete_single_note_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/update_note_usecase.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_add_note_block_command.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_change_note_color_command.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_change_note_title_command.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_remove_note_block_command.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_toggle_archive_command.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_toggle_note_star_command.dart';
import 'package:quick_note/feature/notebook/domain/command_manager/notebook_command_manager.dart';
import 'package:quick_note/feature/notebook/domain/usecase/get_note_by_key_usecase.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_colors.dart';

part 'notebook_event.dart';
part 'notebook_state.dart';

class NotebookBloc extends Bloc<NotebookEvent, NotebookState> {
  NotebookBloc({
    required this.commandManager,
    required this.createNote,
    required this.updateSingleNote,
    required this.deleteNote,
    required this.getNoteByKey,
  }) : super(NotebookInitial()) {
    on<NotebookGetNote>(_handleGetNote);
    on<NotebookCreateNote>(_handleCreateNote);
    on<NotebookUpdateNote>(_handleUpdateNote);
    on<NotebookDeleteBlock>(_handleDeleteBlock);
    on<NotebookAddNoteBlock>(_handleAddNoteBlock);
    on<NotebookUpdateNoteBlock>(_updateNoteBlock);
    on<NotebookChangeColor>(_changeColor);
    on<NotebookToggleStar>(_toggleStar);
    on<NotebookToggleArchive>(_toggleArchive);
    on<NotebookMoveToTrash>(_handleMoveToTrash);
    on<NotebookDeleteNote>(_handleDeleteNote);
    on<NotebookChangeNoteTitle>(_changeNoteTitle);
    on<NotebookUndo>(_handleUndo);
    on<NotebookRedo>(_handleRedo);
  }

final NotebookCommandManager commandManager;
  final CreateNoteUsecase createNote;
  final UpdateSingleNoteUsecase updateSingleNote;
  final DeleteSingleNoteUsecase deleteNote;
  final GetNoteByKeyUsecase getNoteByKey;

  FutureOr<void> _handleGetNote(
      NotebookGetNote event, Emitter<NotebookState> emit) async {
    if (event.noteId == null) return;

    final note = await getNoteByKey.call(event.noteId!);
    note.fold(
      (failure) {},
      (note) => emit(state.copyWith(note: note)),
    );
  }

  FutureOr<void> _handleCreateNote(
      NotebookCreateNote event, Emitter<NotebookState> emit) async {
    final newNote = _createNewNote();
    final result = await createNote.call(newNote);
    result.fold(
      (failure) {},
      (success) => emit(state.copyWith(note: newNote)),
    );
  }

  Note _createNewNote() {
    final now = DateTime.now();
    return Note(
      id: now.millisecondsSinceEpoch % 0xFFFFFFFF,
      created: now,
      modified: now,
    );
  }

  FutureOr<void> _handleUpdateNote(
      NotebookUpdateNote event, Emitter<NotebookState> emit) async {
    if (state.note == null) return;

    final updates = UpdateSingleNoteParams(
      note: state.note!,
      updates: event.updates,
    );

    final result = await updateSingleNote.call(updates);
    _handleResult(result, () => emit(state.copyWith(note: updates.update())));
  }

  FutureOr<void> _handleDeleteBlock(
      NotebookDeleteBlock event, Emitter<NotebookState> emit) async {
    if (state.note == null) return;

    final command = NotebookRemoveNoteBlockCommand(
        note: state.note, blockId: event.blockId);

    final updates = commandManager.execute(command);

    final noteUpdates = UpdateSingleNoteParams(
      note: state.note!,
      updates: updates,
    );

    final result = await updateSingleNote.call(noteUpdates);
    _handleResult(result, () {
      emit(state.copyWith(note: noteUpdates.update()));
    });
  }

  FutureOr<void> _handleAddNoteBlock(
      NotebookAddNoteBlock event, Emitter<NotebookState> emit) async {
    if (state.note == null) return;

    final block = _createNoteBlock(event.type);
    if (block == null) return;

    final command =
        NotebookAddNoteBlockCommand(note: state.note, noteBlock: block);

    final updates = commandManager.execute(command);

    final noteUpdates = UpdateSingleNoteParams(
      note: state.note!,
      updates: updates,
    );

    final result = await updateSingleNote.call(noteUpdates);
    _handleResult(result, () {
      emit(NotebookNoteBlockAdded.fromState(
        state.copyWith(note: noteUpdates.update()),
        block,
      ));
    });
  }

  NoteBlock? _createNoteBlock(NoteBlockType type) {
    final id = DateTime.now().millisecondsSinceEpoch % 0xFFFFFFFF;
    switch (type) {
      case NoteBlockType.text:
        return TextBlock(id: id);
      case NoteBlockType.todo:
        return TodoBlock(id: id, items: const []);
      case NoteBlockType.bookmarks:
        return BookmarksBlock(id: id);
      default:
        return null;
    }
  }

  void _handleResult<E, S>(Either<E, S> result, Function onSuccess) {
    result.fold(
      (failure) {},
      (success) => onSuccess(),
    );
  }

  FutureOr<void> _updateNoteBlock(
      NotebookUpdateNoteBlock event, Emitter<NotebookState> emit) async {
    if (state.note == null) return;

    final note = state.note!;
    final blockId = event.block.id;
    final updatedBlock = event.block;

    final hasBlock = note.content.any((block) => block.id == blockId);
    if (!hasBlock) return;

    final updatedContent = note.content.map((block) {
      return block.id == blockId ? updatedBlock : block;
    }).toList();

    final updates = UpdateSingleNoteParams(
      note: note,
      updates: NoteUpdates(content: updatedContent),
    );

    final result = await updateSingleNote.call(updates);
    _handleResult(result, () => emit(state.copyWith(note: updates.update())));
  }

  FutureOr<void> _changeColor(
      NotebookChangeColor event, Emitter<NotebookState> emit) async {
    final note = state.note;
    if (note == null) return;

    final command =
        NotebookChangeNoteColorCommand(note: note, color: event.color);

    final updates = commandManager.execute(command);

    final noteUpdates = UpdateSingleNoteParams(
      note: note,
      updates: updates,
    );

    final result = await updateSingleNote.call(noteUpdates);
    _handleResult(
        result, () => emit(state.copyWith(note: noteUpdates.update())));
  }

  FutureOr<void> _toggleStar(
      NotebookToggleStar event, Emitter<NotebookState> emit) async {
    final note = state.note;
    if (note == null) return;

    final command = NotebookToggleNoteStarCommand(note: note);

    final updates = commandManager.execute(command);

    final noteUpdates = UpdateSingleNoteParams(
      note: note,
      updates: updates,
    );

    final result = await updateSingleNote.call(noteUpdates);
    _handleResult(
        result, () => emit(state.copyWith(note: noteUpdates.update())));
  }

  FutureOr<void> _toggleArchive(
      NotebookToggleArchive event, Emitter<NotebookState> emit) async {
    final note = state.note;
    if (note == null) return;

    final command = NotebookToggleArchiveCommand(note: note);

    final updates = commandManager.execute(command);

    final noteUpdates = UpdateSingleNoteParams(
      note: note,
      updates: updates,
    );

    final result = await updateSingleNote.call(noteUpdates);
    _handleResult(
        result, () => emit(state.copyWith(note: noteUpdates.update())));
  }

  FutureOr<void> _handleMoveToTrash(
      NotebookMoveToTrash event, Emitter<NotebookState> emit) async {
    if (state.note == null) return;

    await updateSingleNote.call(
      UpdateSingleNoteParams(
        note: state.note!,
        updates: NoteUpdates(
          expirydate: DateTime.now().add(const Duration(days: 7)),
        ),
      ),
    );
  }

  FutureOr<void> _handleDeleteNote(
      NotebookDeleteNote event, Emitter<NotebookState> emit) async {
    if (state.note == null) return;

    await deleteNote.call(state.note!.id);
  }

  FutureOr<void> _changeNoteTitle(
      NotebookChangeNoteTitle event, Emitter<NotebookState> emit) async {
    if (state.note == null) return;

    final note = state.note!;

    final command =
        NotebookChangeNoteTitleCommand(note: note, newTitle: event.title);

    final updates = commandManager.execute(command);

    final noteUpdates = UpdateSingleNoteParams(
      note: note,
      updates: updates,
    );

    final result = await updateSingleNote.call(noteUpdates);
    _handleResult(
        result, () => emit(state.copyWith(note: noteUpdates.update())));
  }

  FutureOr<void> _handleUndo(
      NotebookUndo event, Emitter<NotebookState> emit) async {
    if (state.note == null) return;
    final note = state.note!;

    final currentCommandType = commandManager.getCurrentUndoType;
    if (currentCommandType == null) return;

    switch (currentCommandType) {
      case NotebookCommandType.global:
        final updates = commandManager.undo();
        if (updates == null) return;

        final noteUpdates = UpdateSingleNoteParams(
          note: note,
          updates: updates,
        );

        final result = await updateSingleNote.call(noteUpdates);
        _handleResult(
          result,
          () => emit(
            NotebookUndoRedoState.fromState(
              state.copyWith(note: noteUpdates.update()),
            ),
          ),
        );
        break;
      case _:
        final command = commandManager.popUndoStack();
        if (command == null) return;
        emit(NotebookNoteBlockCommand.fromState(state, command));
        break;
    }
  }

  FutureOr<void> _handleRedo(
      NotebookRedo event, Emitter<NotebookState> emit) async {
    if (state.note == null) return;
    final note = state.note!;

    final currentCommandType = commandManager.getCurrentRedoType;
    if (currentCommandType == null) return;

    switch (currentCommandType) {
      case NotebookCommandType.global:
        final updates = commandManager.redo();
        if (updates == null) return;

        final noteUpdates = UpdateSingleNoteParams(
          note: note,
          updates: updates,
        );

        final result = await updateSingleNote.call(noteUpdates);
        _handleResult(
          result,
          () => emit(
            NotebookUndoRedoState.fromState(
              state.copyWith(note: noteUpdates.update()),
            ),
          ),
        );
        break;
      case _:
        final command = commandManager.popRedoStack();
        if (command == null) return;
        emit(NotebookNoteBlockCommand.fromState(state, command, false));
        break;
    }
  }
}
