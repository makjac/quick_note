part of 'text_block_cubit.dart';

class TextBlockState extends Equatable {
  const TextBlockState({TextBlock? block, this.command})
      : block = block ?? const TextBlock(id: -1);

  final TextBlock block;
  final NotebookCommand? command;

  TextBlockState copyWith({
    TextBlock? block,
    NotebookCommand? command,
  }) {
    return TextBlockState(
      block: block ?? this.block,
      command: command,
    );
  }

  @override
  List<Object> get props => [
        block,
        command ?? -1,
      ];
}

class TextBlockUndoRedoState extends TextBlockState {
  factory TextBlockUndoRedoState.fromState(TextBlockState state) {
    return TextBlockUndoRedoState(
      block: state.block,
    );
  }

  const TextBlockUndoRedoState({super.block});

  @override
  List<Object> get props => [super.props];
}

final class TextBlockInitial extends TextBlockState {}
