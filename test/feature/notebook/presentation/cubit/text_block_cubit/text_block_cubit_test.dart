import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/presentation/cubit/text_block_cubit/text_block_cubit.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';

void main() {
  group('TextBlockCubit', () {
    late TextBlockCubit cubit;
    late TextBlock initialBlock;

    setUp(() {
      initialBlock = const TextBlock(
        id: 1,
        text: 'Initial Text',
        hasMaxLineLimit: false,
        maxLines: 3,
      );
      cubit = TextBlockCubit(block: initialBlock);
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
        const TextBlockState(
          block: TextBlock(
            id: 1,
            text: 'Updated Text',
            hasMaxLineLimit: false,
            maxLines: 3,
          ),
        ),
      ],
    );

    blocTest<TextBlockCubit, TextBlockState>(
      'changeBlockTitle updates the title and sets hasTitle to true',
      build: () => cubit,
      act: (cubit) => cubit.changeBlockTitle('New Title'),
      expect: () => [
        const TextBlockState(
          block: TextBlock(
            id: 1,
            text: 'Initial Text',
            title: 'New Title',
            hasTitle: true,
            hasMaxLineLimit: false,
            maxLines: 3,
          ),
        ),
      ],
    );

    blocTest<TextBlockCubit, TextBlockState>(
      'changeBlockTitleVisibility updates the hasTitle property',
      build: () => cubit,
      act: (cubit) => cubit.changeBlockTitleVisibility(false),
      expect: () => [
        const TextBlockState(
          block: TextBlock(
            id: 1,
            text: 'Initial Text',
            hasTitle: false,
            hasMaxLineLimit: false,
            maxLines: 3,
          ),
        ),
      ],
    );

    blocTest<TextBlockCubit, TextBlockState>(
      'setMaxLinesLimitOption updates hasMaxLineLimit property',
      build: () => cubit,
      act: (cubit) => cubit.setMaxLinesLimitOption(true),
      expect: () => [
        const TextBlockState(
          block: TextBlock(
            id: 1,
            text: 'Initial Text',
            hasTitle: true,
            hasMaxLineLimit: true,
            maxLines: 3,
          ),
        ),
      ],
    );

    blocTest<TextBlockCubit, TextBlockState>(
      'setTextLinecountLimit updates maxLines property',
      build: () => cubit,
      act: (cubit) => cubit.setTextLinecountLimit(10),
      expect: () => [
        const TextBlockState(
          block: TextBlock(
            id: 1,
            text: 'Initial Text',
            hasTitle: true,
            hasMaxLineLimit: false,
            maxLines: 10,
          ),
        ),
      ],
    );
  });
}
