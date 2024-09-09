import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/presentation/cubit/text_block_cubit/text_block_cubit.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';

void main() {
  group('TextBlockState', () {
    late TextBlock initialBlock;
    late TextBlockState state;

    setUp(() {
      initialBlock = const TextBlock(id: 1, text: 'Sample Text');
      state = TextBlockState(block: initialBlock);
    });

    test('constructor initializes state correctly', () {
      expect(state.block, equals(initialBlock));
    });

    test('copyWith returns a new instance with updated values', () {
      const newBlock = TextBlock(id: 2, text: 'New Sample Text');
      final newState = state.copyWith(block: newBlock);

      expect(newState.block, equals(newBlock));
      expect(newState.block, isNot(equals(state.block)));
    });

    test('copyWith returns the same instance when no arguments are provided',
        () {
      final newState = state.copyWith();
      expect(newState, equals(state));
    });

    test('TextBlockInitial is a subtype of TextBlockState', () {
      final initialState = TextBlockInitial();
      expect(initialState, isA<TextBlockState>());
      expect(initialState.block, equals(const TextBlock(id: -1)));
    });

    test('TextBlockState props are correct', () {
      final props = state.props;
      expect(props, [initialBlock, -1]);
    });
  });
    });
  });
}
