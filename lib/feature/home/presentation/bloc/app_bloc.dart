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
    on<LoadCachedNotes>(_loadCachedNotes);
    on<CreateNote>(_createNote);
    on<UpdateSingleNote>(_updateSingleNote);
    on<UpdateSelectedNotes>(_updateSelectedNotes);
    on<StarSelectedNotes>(_starSelectedNotes);
    on<ArchiveSelectedNotes>(_archiveSelectedNotes);
    on<DeleteSingleNote>(_deleteSingleNote);
    on<DeleteAllNotes>(_deleteAllNotes);
    on<DeleteSelectedNotes>(_deleteSelectedNotes);
    on<SelectNote>(_selectNote);
    on<UnselectAllNotes>(_unselectAllNotes);
    on<SelectAllNotes>(_selectAllNotes);
  }

  FutureOr<void> _loadCachedNotes(
      LoadCachedNotes event, Emitter<AppState> emit) async {
    final notes = await loadCachedNotes.call(NoParams());

    notes.fold((failure) {}, (notes) => emit(state.copyWith(notes: notes)));
  }

  FutureOr<void> _createNote(CreateNote event, Emitter<AppState> emit) async {
    final result = await createNote.call(event.note);

    result.fold(
      (failure) {
        if (failure is CacheValueFailure) {
          emit(AppError.fromState(state, "Incorrect value..."));
        } else if (failure is CacheFailure) {
          emit(AppError.fromState(state, "Unable to create note..."));
        }
        emit(AppError.fromState(state, "Unable to create note..."));
      },
      (result) => emit(state.copyWith(notes: [...state.notes, event.note])),
    );
  }

  FutureOr<void> _updateSingleNote(
      UpdateSingleNote event, Emitter<AppState> emit) async {
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
      UpdateSelectedNotes event, Emitter<AppState> emit) async {
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
      StarSelectedNotes event, Emitter<AppState> emit) async {
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
      ArchiveSelectedNotes event, Emitter<AppState> emit) async {
    final isAllArchived = state.selectedNoteIds.every(
        (id) => state.notes.singleWhere((note) => note.id == id).archived);

    final result = await updateMultipleNotes.call(UpdateNotesParams(
        keys: state.selectedNoteIds,
        updates: NoteUpdates(isStarred: !isAllArchived)));

    if (result.isRight()) {
      final notes = await loadCachedNotes.call(NoParams());

      notes.fold((failure) {}, (notes) {
        emit(AppState(notes: notes));
      });
    }
  }

  FutureOr<void> _deleteSingleNote(
      DeleteSingleNote event, Emitter<AppState> emit) async {
    final result = await deleteSingleNote.call(event.id);

    if (result.isRight()) {
      final notes = await loadCachedNotes.call(NoParams());

      notes.fold((failure) {}, (notes) {
        emit(AppState(notes: notes));
      });
    }
  }

  FutureOr<void> _deleteAllNotes(
      DeleteAllNotes event, Emitter<AppState> emit) async {
    final result = await deleteAllNotes.call(NoParams());

    result.fold((failure) {}, (result) => emit(state.copyWith(notes: [])));
  }

  FutureOr<void> _deleteSelectedNotes(
      DeleteSelectedNotes event, Emitter<AppState> emit) async {
    final result =
        await deleteMultipleNotes.call(state.selectedNoteIds.toList());

    if (result.isRight()) {
      final notes = await loadCachedNotes.call(NoParams());

      notes.fold((failure) {}, (notes) {
        emit(AppState(notes: notes));
      });
    }
  }

  FutureOr<void> _selectNote(SelectNote event, Emitter<AppState> emit) async {
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
      UnselectAllNotes event, Emitter<AppState> emit) async {
    emit(state.copyWith(
      selectedNoteIds: {},
      isSelecting: false,
    ));
  }

  FutureOr<void> _selectAllNotes(
      SelectAllNotes event, Emitter<AppState> emit) async {
    emit(state.copyWith(
      selectedNoteIds: state.notes.map((note) => note.id).toSet(),
      isSelecting: true,
    ));
  }
}
