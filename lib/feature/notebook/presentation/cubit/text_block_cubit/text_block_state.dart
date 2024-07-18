part of 'text_block_cubit.dart';

class TextBlockState extends Equatable {
  const TextBlockState({TextBlock? block})
      : block = block ?? const TextBlock(id: -1);

  final TextBlock block;

  TextBlockState copyWith({TextBlock? block}) {
    return TextBlockState(block: block ?? this.block);
  }

  @override
  List<Object> get props => [block];
}

final class TextBlockInitial extends TextBlockState {}
