import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quick_note/feature/notebook/domain/command/text_block_command/text_block_change_note_text_command.dart';
import 'package:quick_note/feature/notebook/domain/command/text_block_command/text_block_set_text_line_limit_command.dart';
import 'package:quick_note/feature/notebook/domain/command/text_block_command/text_block_title_visibility_command.dart';
import 'package:quick_note/feature/notebook/domain/command/text_block_command/text_block_toggle_lines_limit_command.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/feature/notebook/presentation/cubit/text_block_cubit/text_block_cubit.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';

class MockNotebookBloc extends Mock implements NotebookBloc {}

void main() {
  group('TextBlockCubit', () {
    late TextBlockCubit cubit;
    late TextBlock initialBlock;
    late NotebookBloc mockNotebookBloc;

    setUp(() {
      mockNotebookBloc = MockNotebookBloc();

      when(() => mockNotebookBloc.stream)
          .thenAnswer((_) => const Stream<NotebookState>.empty());

      initialBlock = const TextBlock(
        id: 1,
        text: 'Initial Text',
        hasMaxLineLimit: false,
        maxLines: 3,
      );
      cubit = TextBlockCubit(
        block: initialBlock,
        notebookBloc: mockNotebookBloc,
      );
    });

    test('initial state is correct', () {
      expect(cubit.state, equals(TextBlockState(block: initialBlock)));
    });

    blocTest<TextBlockCubit, TextBlockState>(
      'loadNoteBlock updates the block',
      build: () => cubit,
      act: (cubit) => cubit.loadNoteBlock(
        const TextBlock(
          id: 2,
          text: 'New Text',
          hasMaxLineLimit: true,
          maxLines: 5,
        ),
      ),
      expect: () => [
        const TextBlockState(
          block: TextBlock(
            id: 2,
            text: 'New Text',
            hasMaxLineLimit: true,
            maxLines: 5,
          ),
        ),
      ],
    );

    blocTest<TextBlockCubit, TextBlockState>(
      'changeNoteText updates the text',
      build: () => cubit,
      act: (cubit) => cubit.changeNoteText('Updated Text'),
      expect: () => [
        isA<TextBlockState>()
            .having(
              (state) => state.block.text,
              'text',
              'Updated Text',
            )
            .having(
              (state) => state.command,
              'command',
              isA<TextBlockChangeNoteTextCommand>(),
            ),
      ],
    );

    blocTest<TextBlockCubit, TextBlockState>(
      'changeBlockTitleVisibility updates the hasTitle property',
      build: () => cubit,
      act: (cubit) => cubit.changeBlockTitleVisibility(false),
      expect: () => [
        isA<TextBlockState>()
            .having(
              (state) => state.block.hasTitle,
              'hasTitle',
              false,
            )
            .having(
              (state) => state.command,
              'command',
              isA<TextBlockTitleVisibilityCommand>(),
            ),
      ],
    );

    blocTest<TextBlockCubit, TextBlockState>(
      'setMaxLinesLimitOption updates hasMaxLineLimit property',
      build: () => cubit,
      act: (cubit) => cubit.setMaxLinesLimitOption(true),
      expect: () => [
        isA<TextBlockState>()
            .having(
              (state) => state.block.hasMaxLineLimit,
              'hasMaxLineLimit',
              true,
            )
            .having(
              (state) => state.command,
              'command',
              isA<TextBlockToggleLinesLimitCommand>(),
            ),
      ],
    );

    blocTest<TextBlockCubit, TextBlockState>(
      'setTextLinecountLimit updates maxLines property',
      build: () => cubit,
      act: (cubit) => cubit.setTextLinecountLimit(10),
      expect: () => [
        isA<TextBlockState>()
            .having(
              (state) => state.block.maxLines,
              'maxLines',
              10,
            )
            .having(
              (state) => state.command,
              'command',
              isA<TextBlockSetTextLineLimitCommand>(),
            ),
      ],
    );
  });
}
