import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/presentation/cubit/reorder_note_block/reorder_note_block_cubit.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';

void main() {
  group('ReorderNoteBlockState', () {
    late NoteBlock block1;
    late NoteBlock block2;
    late List<NoteBlock> initialBlocks;
    late List<NoteBlock> blocks;
    late ReorderNoteBlockState state;

    setUp(() {
      block1 = const TextBlock(id: 1);
      block2 = const TextBlock(id: 2);
      initialBlocks = [block1];
      blocks = [block1, block2];
      state = ReorderNoteBlockState(
        initialBlocks: initialBlocks,
        blocks: blocks,
      );
    });

    test('constructor initializes state correctly', () {
      expect(state.initialBlocks, equals(initialBlocks));
      expect(state.blocks, equals(blocks));
    });

    test('copyWith returns a new instance with updated values', () {
      final newInitialBlocks = [block2];
      final newBlocks = [block2, block1];
      final newState = state.copyWith(
        initialBlocks: newInitialBlocks,
        blocks: newBlocks,
      );

      expect(newState.initialBlocks, equals(newInitialBlocks));
      expect(newState.blocks, equals(newBlocks));
      expect(newState, isNot(equals(state)));
    });

    test('copyWith returns the same instance when no arguments are provided',
        () {
      final newState = state.copyWith();
      expect(newState, equals(state));
    });

    test('ReorderNoteBlockInitial is a subtype of ReorderNoteBlockState', () {
      final initialState = ReorderNoteBlockInitial();
      expect(initialState, isA<ReorderNoteBlockState>());
      expect(initialState.initialBlocks, isEmpty);
      expect(initialState.blocks, isEmpty);
    });

    test('ReorderNoteBlockState props are correct', () {
      final props = state.props;
      expect(props, [initialBlocks, blocks]);
    });
  });
}
