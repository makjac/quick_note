import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quick_note/core/error/failure/cache_failure.dart';
import 'package:quick_note/feature/home/domain/usecase/create_note_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/delete_single_note_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/update_note_usecase.dart';
import 'package:quick_note/feature/notebook/domain/usecase/get_note_by_key_usecase.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';

class MockCreateNoteUsecase extends Mock implements CreateNoteUsecase {}

class MockUpdateSingleNoteUsecase extends Mock
    implements UpdateSingleNoteUsecase {}

class MockDeleteSingleNoteUsecase extends Mock
    implements DeleteSingleNoteUsecase {}

class MockGetNoteByKeyUsecase extends Mock implements GetNoteByKeyUsecase {}

class FakeUpdateSingleNoteParams extends Fake
    implements UpdateSingleNoteParams {}

void main() {
  late MockCreateNoteUsecase mockCreateNoteUsecase;
  late MockUpdateSingleNoteUsecase mockUpdateSingleNoteUsecase;
  late MockDeleteSingleNoteUsecase mockDeleteSingleNoteUsecase;
  late MockGetNoteByKeyUsecase mockGetNoteByKeyUsecase;
  late NotebookBloc notebookBloc;

  setUpAll(() {
    registerFallbackValue(FakeUpdateSingleNoteParams());
  });

  setUp(() {
    mockCreateNoteUsecase = MockCreateNoteUsecase();
    mockUpdateSingleNoteUsecase = MockUpdateSingleNoteUsecase();
    mockDeleteSingleNoteUsecase = MockDeleteSingleNoteUsecase();
    mockGetNoteByKeyUsecase = MockGetNoteByKeyUsecase();
    notebookBloc = NotebookBloc(
      createNote: mockCreateNoteUsecase,
      updateSingleNote: mockUpdateSingleNoteUsecase,
      deleteNote: mockDeleteSingleNoteUsecase,
      getNoteByKey: mockGetNoteByKeyUsecase,
    );
  });

  group('NotebookBloc', () {
    test('initial state is NotebookInitial', () {
      expect(notebookBloc.state, isA<NotebookInitial>());
    });

    blocTest<NotebookBloc, NotebookState>(
      'emits [NotebookState] with note when NotebookGetNote is added and succeeds',
      build: () {
        when(() => mockGetNoteByKeyUsecase.call(any())).thenAnswer((_) async =>
            Right(Note(
                id: 1, created: DateTime.now(), modified: DateTime.now())));
        return notebookBloc;
      },
      act: (bloc) => bloc.add(const NotebookGetNote(noteId: 1)),
      expect: () => [
        isA<NotebookState>().having((state) => state.note, 'note', isNotNull),
      ],
    );

    blocTest<NotebookBloc, NotebookState>(
      'emits [NotebookState] with error when NotebookGetNote fails',
      build: () {
        when(() => mockGetNoteByKeyUsecase.call(any()))
            .thenAnswer((_) async => const Left(CacheFailure()));
        return notebookBloc;
      },
      act: (bloc) => bloc.add(const NotebookGetNote(noteId: 1)),
      expect: () => [],
    );

    blocTest<NotebookBloc, NotebookState>(
      'emits [NotebookState] with updated note when NotebookUpdateNote is added',
      build: () {
        when(() => mockUpdateSingleNoteUsecase.call(any()))
            .thenAnswer((_) async => const Right(null));
        return notebookBloc;
      },
      act: (bloc) => bloc.add(const NotebookUpdateNote(updates: NoteUpdates())),
      expect: () => [],
    );

    blocTest<NotebookBloc, NotebookState>(
      'emits [NotebookState] with updated note when NotebookDeleteBlock is added',
      build: () {
        when(() => mockUpdateSingleNoteUsecase.call(any()))
            .thenAnswer((_) async => const Right(null));
        return notebookBloc;
      },
      act: (bloc) => bloc.add(const NotebookDeleteBlock(blockId: 1)),
      expect: () => [],
    );

    blocTest<NotebookBloc, NotebookState>(
      'emits [NotebookState] with updated note when NotebookAddNoteBlock is added',
      build: () {
        when(() => mockUpdateSingleNoteUsecase.call(any()))
            .thenAnswer((_) async => const Right(null));
        return notebookBloc;
      },
      act: (bloc) =>
          bloc.add(const NotebookAddNoteBlock(type: NoteBlockType.text)),
      expect: () => [],
    );

    blocTest<NotebookBloc, NotebookState>(
      'emits [NotebookState] with updated note when NotebookUpdateNoteBlock is added',
      build: () {
        when(() => mockUpdateSingleNoteUsecase.call(any()))
            .thenAnswer((_) async => const Right(null));
        return notebookBloc;
      },
      act: (bloc) =>
          bloc.add(const NotebookUpdateNoteBlock(block: TextBlock(id: 1))),
      expect: () => [],
    );

    blocTest<NotebookBloc, NotebookState>(
      'emits [NotebookState] when NotebookChangeColor is added',
      build: () => notebookBloc,
      act: (bloc) => bloc.add(const NotebookChangeColor(color: 'blue')),
      expect: () => [],
    );

    blocTest<NotebookBloc, NotebookState>(
      'emits [NotebookState] with updated note when NotebookToggleStar is added',
      build: () {
        when(() => mockUpdateSingleNoteUsecase.call(any()))
            .thenAnswer((_) async => const Right(null));
        return notebookBloc;
      },
      act: (bloc) => bloc.add(NotebookToggleStar()),
      expect: () => [],
    );

    blocTest<NotebookBloc, NotebookState>(
      'emits [NotebookNoteDeleted] when NotebookDeleteNote is added',
      build: () {
        when(() => mockUpdateSingleNoteUsecase.call(any()))
            .thenAnswer((_) async => const Right(null));
        return notebookBloc;
      },
      act: (bloc) => bloc.add(NotebookDeleteNote()),
      expect: () => [],
    );
  });
}
