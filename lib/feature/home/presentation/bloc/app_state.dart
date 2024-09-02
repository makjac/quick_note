part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState({
    List<Note>? notes,
    Set<num>? selectedNoteIds,
    bool? isSelecting,
  })  : notes = notes ?? const [],
        selectedNoteIds = selectedNoteIds ?? const <num>{},
        isSelecting = isSelecting ?? false;

  final List<Note> notes;
  final Set<num> selectedNoteIds;
  final bool isSelecting;

  AppState copyWith({
    List<Note>? notes,
    Set<num>? selectedNoteIds,
    bool? isSelecting,
    String? searchTerm,
  }) {
    return AppState(
      notes: notes ?? this.notes,
      selectedNoteIds: selectedNoteIds ?? this.selectedNoteIds,
      isSelecting: isSelecting ?? this.isSelecting,
    );
  }

  @override
  List<Object> get props => [notes, selectedNoteIds, isSelecting];
}

final class AppInitial extends AppState {}

class AppNoteCreated extends AppState {
  factory AppNoteCreated.fromState(AppState state, num createdNoteId) {
    return AppNoteCreated(
      notes: state.notes,
      selectedNoteIds: state.selectedNoteIds,
      isSelecting: state.isSelecting,
      createdNoteId: createdNoteId,
    );
  }
  const AppNoteCreated({
    super.notes,
    super.selectedNoteIds,
    super.isSelecting,
    required this.createdNoteId,
  });

  final num createdNoteId;

  @override
  List<Object> get props => [
        notes,
        selectedNoteIds,
        isSelecting,
        createdNoteId,
      ];
}

class AppError extends AppState {
  factory AppError.fromState(AppState state, String error) {
    return AppError(
      notes: state.notes,
      selectedNoteIds: state.selectedNoteIds,
      isSelecting: state.isSelecting,
      errorMessage: error,
    );
  }
  const AppError({
    super.notes,
    super.selectedNoteIds,
    super.isSelecting,
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object> get props => [notes, selectedNoteIds, isSelecting, errorMessage];
}
