import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quick_note/feature/home/domain/usecase/create_note_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/delete_single_note_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/update_note_usecase.dart';
import 'package:quick_note/feature/notebook/domain/usecase/get_note_by_key_usecase.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

part 'notebook_event.dart';
part 'notebook_state.dart';

class NotebookBloc extends Bloc<NotebookEvent, NotebookState> {
  final CreateNoteUsecase createNote;
  final UpdateSingleNoteUsecase updateSingleNote;
  final DeleteSingleNoteUsecase deleteNote;
  final GetNoteByKeyUsecase getNoteByKey;

  NotebookBloc({
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
    on<NotebookDeleteNote>(_handleDeleteNote);
  }

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

    final updatedContent = state.note!.content
        .where((block) => block.id != event.blockId)
        .toList();

    final updates = UpdateSingleNoteParams(
      note: state.note!,
      updates: NoteUpdates(content: updatedContent),
    );

    final result = await updateSingleNote.call(updates);
    _handleResult(result, () => emit(state.copyWith(note: updates.update())));
  }

  FutureOr<void> _handleAddNoteBlock(
      NotebookAddNoteBlock event, Emitter<NotebookState> emit) async {
    if (state.note == null) return;

    final block = _createNoteBlock(event.type);
    if (block == null) return;

    final updates = UpdateSingleNoteParams(
      note: state.note!,
      updates: NoteUpdates(content: [...state.note!.content, block]),
    );

    final result = await updateSingleNote.call(updates);
    _handleResult(result, () => emit(state.copyWith(note: updates.update())));
  }

  NoteBlock? _createNoteBlock(NoteBlockType type) {
    final id = DateTime.now().millisecondsSinceEpoch % 0xFFFFFFFF;
    switch (type) {
      case NoteBlockType.text:
        return TextBlock(id: id);
      case NoteBlockType.todo:
        return TodoBlock(id: id, items: const []);
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
      NotebookChangeColor event, Emitter<NotebookState> emit) async {}

  FutureOr<void> _toggleStar(
      NotebookToggleStar event, Emitter<NotebookState> emit) async {
    final note = state.note;

    if (note == null) return;

    final updates = UpdateSingleNoteParams(
      note: note,
      updates: NoteUpdates(isStarred: !note.isStarred),
    );

    final result = await updateSingleNote.call(updates);
    _handleResult(result, () => emit(state.copyWith(note: updates.update())));
  }

  FutureOr<void> _toggleArchive(
      NotebookToggleArchive event, Emitter<NotebookState> emit) async {
    final note = state.note;

    if (note == null) return;

    final updates = UpdateSingleNoteParams(
      note: note,
      updates: NoteUpdates(archived: !note.archived),
    );

    final result = await updateSingleNote.call(updates);
    _handleResult(result, () => emit(state.copyWith(note: updates.update())));
  }

  FutureOr<void> _handleDeleteNote(
      NotebookDeleteNote event, Emitter<NotebookState> emit) async {
    final result = await deleteNote.call(state.note?.id ?? -1);
    _handleResult(result, () => emit(NotebookNoteDeleted()));
  }
}
