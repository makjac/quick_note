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

class AppError extends AppState {
  const AppError({
    super.notes,
    super.selectedNoteIds,
    super.isSelecting,
    required this.errorMessage,
  });

  final String errorMessage;

  factory AppError.fromState(AppState state, String error) {
    return AppError(
      notes: state.notes,
      selectedNoteIds: state.selectedNoteIds,
      isSelecting: state.isSelecting,
      errorMessage: error,
    );
  }

  @override
  List<Object> get props => [notes, selectedNoteIds, isSelecting, errorMessage];
}
