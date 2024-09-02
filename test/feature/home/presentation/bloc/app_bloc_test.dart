import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quick_note/core/error/failure/cache_failure.dart';
import 'package:quick_note/core/usecase/usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/create_note_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/delete_all_notes_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/delete_empty_notes_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/delete_miltiple_notes_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/delete_single_note_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/load_cached_notes_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/update_note_usecase.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';

class MockLoadCachedNotesUsecase extends Mock
    implements LoadCachedNotesUsecase {}

class MockCreateNoteUsecase extends Mock implements CreateNoteUsecase {}

class MockDeleteAllNotesUsecase extends Mock implements DeleteAllNotesUsecase {}

class MockDeleteMiltipleNotesUsecase extends Mock
    implements DeleteMiltipleNotesUsecase {}

class MockDeleteSingleNoteUsecase extends Mock
    implements DeleteSingleNoteUsecase {}

class MockUpdateMultipleNotesUsecase extends Mock
    implements UpdateMultipleNotesUsecase {}

class MockUpdateSingleNoteUsecase extends Mock
    implements UpdateSingleNoteUsecase {}

class MockDeleteEmptyNotesUsecase extends Mock
    implements DeleteEmptyNotesUsecase {}

// Dummy Classes
class NoteFake extends Fake implements Note {}

void main() {
  late AppBloc appBloc;
  late MockLoadCachedNotesUsecase mockLoadCachedNotes;
  late MockCreateNoteUsecase mockCreateNote;
  late MockDeleteAllNotesUsecase mockDeleteAllNotes;
  late MockDeleteMiltipleNotesUsecase mockDeleteMiltipleNotes;
  late MockDeleteSingleNoteUsecase mockDeleteSingleNote;
  late MockUpdateMultipleNotesUsecase mockUpdateMultipleNotes;
  late MockUpdateSingleNoteUsecase mockUpdateSingleNote;
  late MockDeleteEmptyNotesUsecase mockDeleteEmptyNotes;

  late Note note;

  setUpAll(() {
    final Set<num> selectedNoteIds = {};
    registerFallbackValue(NoteFake());
    registerFallbackValue(NoParams());
    registerFallbackValue(
        UpdateSingleNoteParams(note: NoteFake(), updates: const NoteUpdates()));
    registerFallbackValue(
        UpdateNotesParams(updates: const NoteUpdates(), keys: selectedNoteIds));
  });

  setUp(() {
    mockLoadCachedNotes = MockLoadCachedNotesUsecase();
    mockCreateNote = MockCreateNoteUsecase();
    mockDeleteAllNotes = MockDeleteAllNotesUsecase();
    mockDeleteMiltipleNotes = MockDeleteMiltipleNotesUsecase();
    mockDeleteSingleNote = MockDeleteSingleNoteUsecase();
    mockUpdateMultipleNotes = MockUpdateMultipleNotesUsecase();
    mockUpdateSingleNote = MockUpdateSingleNoteUsecase();
    mockDeleteEmptyNotes = MockDeleteEmptyNotesUsecase();

    note = Note(
      id: 1,
      title: 'Test',
      content: const [],
      created: DateTime.now(),
      modified: DateTime.now(),
    );

    appBloc = AppBloc(
      loadCachedNotes: mockLoadCachedNotes,
      createNote: mockCreateNote,
      deleteAllNotes: mockDeleteAllNotes,
      deleteMultipleNotes: mockDeleteMiltipleNotes,
      updateMultipleNotes: mockUpdateMultipleNotes,
      updateSingleNote: mockUpdateSingleNote,
      deleteSingleNote: mockDeleteSingleNote,
      deleteEmptyNotes: mockDeleteEmptyNotes,
    );
  });

  tearDown(() {
    appBloc.close();
  });

  group('AppBloc', () {
    test('initial state should be AppInitial', () {
      expect(appBloc.state, equals(AppInitial()));
    });

    blocTest<AppBloc, AppState>(
      'emits [AppState] when AppLoadCachedNotes is added and success',
      build: () {
        when(() => mockLoadCachedNotes.call(NoParams()))
            .thenAnswer((_) async => Right([note]));
        when(() => mockDeleteEmptyNotes.call(NoParams()))
            .thenAnswer((_) async => const Right(null));
        return appBloc;
      },
      act: (bloc) => bloc.add(AppLoadCachedNotes()),
      expect: () => [
        AppState(notes: [note]),
      ],
    );

    blocTest<AppBloc, AppState>(
      'emits [AppError] when AppCreateNote is added and failure',
      build: () {
        when(() => mockCreateNote.call(any()))
            .thenAnswer((_) async => const Left(CacheFailure()));
        return appBloc;
      },
      act: (bloc) => bloc.add(AppCreateNote()),
      expect: () => [
        AppError.fromState(const AppState(), "Unable to create note..."),
      ],
    );

    blocTest<AppBloc, AppState>(
      'emits [AppState] when AppUpdateSingleNote is added and success',
      build: () {
        when(() => mockUpdateSingleNote.call(any()))
            .thenAnswer((_) async => const Right(null));
        when(() => mockLoadCachedNotes.call(NoParams()))
            .thenAnswer((_) async => Right([note]));
        return appBloc;
      },
      act: (bloc) => bloc.add(AppUpdateSingleNote(
        note: note,
        updates: const NoteUpdates(title: 'Updated Note'),
      )),
      expect: () => [
        AppState(notes: [note]),
      ],
    );

    blocTest<AppBloc, AppState>(
      'emits [AppState] when AppDeleteSingleNote is added and success',
      build: () {
        when(() => mockDeleteSingleNote.call(any()))
            .thenAnswer((_) async => const Right(null));
        when(() => mockLoadCachedNotes.call(NoParams()))
            .thenAnswer((_) async => const Right([]));
        return appBloc;
      },
      act: (bloc) => bloc.add(const AppDeleteSingleNote(id: 1)),
      expect: () => [
        const AppState(notes: []),
      ],
    );

    blocTest<AppBloc, AppState>(
      'emits [AppState] when AppDeleteAllNotes is added and success',
      build: () {
        when(() => mockDeleteAllNotes.call(NoParams()))
            .thenAnswer((_) async => const Right(1));
        return appBloc;
      },
      act: (bloc) => bloc.add(AppDeleteAllNotes()),
      expect: () => [
        const AppState(notes: []),
      ],
    );

    blocTest<AppBloc, AppState>(
      'emits [AppState] when AppUpdateSelectedNotes is added and success',
      build: () {
        when(() => mockUpdateMultipleNotes.call(any()))
            .thenAnswer((_) async => const Right(null));
        when(() => mockLoadCachedNotes.call(NoParams()))
            .thenAnswer((_) async => Right([note]));
        return appBloc;
      },
      act: (bloc) => bloc.add(const AppUpdateSelectedNotes(
        updates: NoteUpdates(title: 'Updated Note'),
      )),
      expect: () => [
        AppState(notes: [note]),
      ],
    );

    blocTest<AppBloc, AppState>(
      'emits [AppState] when AppStarSelectedNotes is added and success',
      build: () {
        when(() => mockUpdateMultipleNotes.call(any()))
            .thenAnswer((_) async => const Right(null));
        when(() => mockLoadCachedNotes.call(NoParams()))
            .thenAnswer((_) async => Right([note]));
        return appBloc;
      },
      act: (bloc) => bloc.add(AppStarSelectedNotes()),
      expect: () => [
        AppState(notes: [note]),
      ],
    );

    blocTest<AppBloc, AppState>(
      'emits [AppState] when AppArchiveSelectedNotes is added and success',
      build: () {
        when(() => mockUpdateMultipleNotes.call(any()))
            .thenAnswer((_) async => const Right(null));
        when(() => mockLoadCachedNotes.call(NoParams()))
            .thenAnswer((_) async => Right([note]));
        return appBloc;
      },
      act: (bloc) => bloc.add(AppArchiveSelectedNotes()),
      expect: () => [
        AppState(notes: [note]),
      ],
    );
  });
}
