import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/presentation/cubit/reorder_note_block/reorder_note_block_cubit.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';

void main() {
  group('ReorderNoteBlockCubit', () {
    late ReorderNoteBlockCubit cubit;
    late List<NoteBlock> blocks;
    late NoteBlock block1;
    late NoteBlock block2;
    late NoteBlock block3;

    setUp(() {
      block1 = const TextBlock(id: 1);
      block2 = const TextBlock(id: 2);
      block3 = const TextBlock(id: 3);
      blocks = [block1, block2, block3];
      cubit = ReorderNoteBlockCubit(blocks: blocks);
    });

    test('initial state is correct', () {
      expect(cubit.state,
          equals(ReorderNoteBlockState(initialBlocks: blocks, blocks: blocks)));
    });

    blocTest<ReorderNoteBlockCubit, ReorderNoteBlockState>(
      'reorderNoteBlocks reorders blocks correctly',
      build: () => cubit,
      act: (cubit) => cubit.reorderNoteBlocks(0, 2),
      expect: () => [
        ReorderNoteBlockState(
          initialBlocks: blocks,
          blocks: [
            block2,
            block3,
            block1
          ], // Block1 moved from index 0 to index 2
        ),
      ],
    );

    blocTest<ReorderNoteBlockCubit, ReorderNoteBlockState>(
      'reorderNoteBlocks does nothing if oldIndex is out of range',
      build: () => cubit,
      act: (cubit) => cubit.reorderNoteBlocks(-1, 2),
      expect: () => [],
    );

    blocTest<ReorderNoteBlockCubit, ReorderNoteBlockState>(
      'reorderNoteBlocks does nothing if newIndex is out of range',
      build: () => cubit,
      act: (cubit) => cubit.reorderNoteBlocks(0, 5),
      expect: () => [],
    );

    blocTest<ReorderNoteBlockCubit, ReorderNoteBlockState>(
      'reorderNoteBlocks does nothing if oldIndex and newIndex are the same',
      build: () => cubit,
      act: (cubit) => cubit.reorderNoteBlocks(1, 1),
      expect: () =>
          [ReorderNoteBlockState(initialBlocks: blocks, blocks: blocks)],
    );
  });
}
