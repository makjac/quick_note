import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quick_note/core/error/failure/cache_failure.dart';
import 'package:quick_note/core/error/failure/cache_value_failure.dart';
import 'package:quick_note/core/usecase/usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/create_note_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/delete_all_notes_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/delete_miltiple_notes_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/delete_single_note_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/load_cached_notes_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/update_note_usecase.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final LoadCachedNotesUsecase loadCachedNotes;
  final CreateNoteUsecase createNote;
  final DeleteAllNotesUsecase deleteAllNotes;
  final DeleteMiltipleNotesUsecase deleteMultipleNotes;
  final UpdateMultipleNotesUsecase updateMultipleNotes;
  final UpdateSingleNoteUsecase updateSingleNote;
  final DeleteSingleNoteUsecase deleteSingleNote;

  AppBloc({
    required this.loadCachedNotes,
    required this.createNote,
    required this.deleteAllNotes,
    required this.deleteMultipleNotes,
    required this.updateMultipleNotes,
    required this.updateSingleNote,
    required this.deleteSingleNote,
  }) : super(AppInitial()) {
    on<AppLoadCachedNotes>(_loadCachedNotes);
    on<AppCreateNote>(_createNote);
    on<AppUpdateSingleNote>(_updateSingleNote);
    on<AppUpdateSelectedNotes>(_updateSelectedNotes);
    on<AppStarSelectedNotes>(_starSelectedNotes);
    on<AppArchiveSelectedNotes>(_archiveSelectedNotes);
    on<AppDeleteSingleNote>(_deleteSingleNote);
    on<AppDeleteAllNotes>(_deleteAllNotes);
    on<AppDeleteSelectedNotes>(_deleteSelectedNotes);
    on<AppSelectNote>(_selectNote);
    on<AppUnselectAllNotes>(_unselectAllNotes);
    on<AppSelectAllNotes>(_selectAllNotes);
  }

  FutureOr<void> _loadCachedNotes(
      AppLoadCachedNotes event, Emitter<AppState> emit) async {
    final notes = await loadCachedNotes.call(NoParams());

    notes.fold((failure) {}, (notes) => emit(state.copyWith(notes: notes)));
  }

  FutureOr<void> _createNote(
      AppCreateNote event, Emitter<AppState> emit) async {
    final newID = DateTime.now().millisecondsSinceEpoch % 0xFFFFFFFF;
    final note = Note(
      id: newID,
      created: DateTime.now(),
      modified: DateTime.now(),
    );

    final result = await createNote.call(note);

    result.fold(
      (failure) {
        if (failure is CacheValueFailure) {
          emit(AppError.fromState(state, "Incorrect value..."));
        } else if (failure is CacheFailure) {
          emit(AppError.fromState(state, "Unable to create note..."));
        }
        emit(AppError.fromState(state, "Unable to create note..."));
      },
      (result) => emit(AppNoteCreated.fromState(
        state.copyWith(notes: [...state.notes, note]),
        newID,
      )),
    );
  }

  FutureOr<void> _updateSingleNote(
      AppUpdateSingleNote event, Emitter<AppState> emit) async {
    final result = await updateSingleNote
        .call(UpdateSingleNoteParams(note: event.note, updates: event.updates));

    if (result.isRight()) {
      final notes = await loadCachedNotes.call(NoParams());

      notes.fold((failure) {}, (notes) {
        emit(AppState(notes: notes));
      });
    }
  }

  FutureOr<void> _updateSelectedNotes(
      AppUpdateSelectedNotes event, Emitter<AppState> emit) async {
    final result = await updateMultipleNotes.call(
        UpdateNotesParams(keys: state.selectedNoteIds, updates: event.updates));

    if (result.isRight()) {
      final notes = await loadCachedNotes.call(NoParams());

      notes.fold((failure) {}, (notes) {
        emit(AppState(notes: notes));
      });
    }
  }

  FutureOr<void> _starSelectedNotes(
      AppStarSelectedNotes event, Emitter<AppState> emit) async {
    final isAllStared = state.selectedNoteIds.every(
        (id) => state.notes.singleWhere((note) => note.id == id).isStarred);

    final result = await updateMultipleNotes.call(UpdateNotesParams(
        keys: state.selectedNoteIds,
        updates: NoteUpdates(isStarred: !isAllStared)));

    if (result.isRight()) {
      final notes = await loadCachedNotes.call(NoParams());

      notes.fold((failure) {}, (notes) {
        emit(AppState(notes: notes));
      });
    }
  }

  FutureOr<void> _archiveSelectedNotes(
      AppArchiveSelectedNotes event, Emitter<AppState> emit) async {
    final isAllArchived = state.selectedNoteIds.every(
        (id) => state.notes.singleWhere((note) => note.id == id).archived);

    final result = await updateMultipleNotes.call(UpdateNotesParams(
        keys: state.selectedNoteIds,
        updates: NoteUpdates(
          archived: !isAllArchived,
          isStarred: false,
        )));

    if (result.isRight()) {
      final notes = await loadCachedNotes.call(NoParams());

      notes.fold((failure) {}, (notes) {
        emit(AppState(notes: notes));
      });
    }
  }

  FutureOr<void> _deleteSingleNote(
      AppDeleteSingleNote event, Emitter<AppState> emit) async {
    final result = await deleteSingleNote.call(event.id);

    if (result.isRight()) {
      final notes = await loadCachedNotes.call(NoParams());

      notes.fold((failure) {}, (notes) {
        emit(AppState(notes: notes));
      });
    }
  }

  FutureOr<void> _deleteAllNotes(
      AppDeleteAllNotes event, Emitter<AppState> emit) async {
    final result = await deleteAllNotes.call(NoParams());

    result.fold((failure) {}, (result) => emit(state.copyWith(notes: [])));
  }

  FutureOr<void> _deleteSelectedNotes(
      AppDeleteSelectedNotes event, Emitter<AppState> emit) async {
    final result =
        await deleteMultipleNotes.call(state.selectedNoteIds.toList());

    if (result.isRight()) {
      final notes = await loadCachedNotes.call(NoParams());

      notes.fold((failure) {}, (notes) {
        emit(AppState(notes: notes));
      });
    }
  }

  FutureOr<void> _selectNote(
      AppSelectNote event, Emitter<AppState> emit) async {
    final isSelected = state.selectedNoteIds.contains(event.noteId);

    if (isSelected) {
      final updatedSelectedNoteIds = Set<num>.from(state.selectedNoteIds);
      updatedSelectedNoteIds.remove(event.noteId);
      emit(state.copyWith(
        selectedNoteIds: updatedSelectedNoteIds,
        isSelecting: updatedSelectedNoteIds.isNotEmpty,
      ));
    } else {
      emit(state.copyWith(
        selectedNoteIds: {...state.selectedNoteIds, event.noteId},
        isSelecting: true,
      ));
    }
  }

  FutureOr<void> _unselectAllNotes(
      AppUnselectAllNotes event, Emitter<AppState> emit) async {
    emit(state.copyWith(
      selectedNoteIds: {},
      isSelecting: false,
    ));
  }

  FutureOr<void> _selectAllNotes(
      AppSelectAllNotes event, Emitter<AppState> emit) async {
    emit(state.copyWith(
      selectedNoteIds: state.notes.map((note) => note.id).toSet(),
      isSelecting: true,
    ));
  }
}
