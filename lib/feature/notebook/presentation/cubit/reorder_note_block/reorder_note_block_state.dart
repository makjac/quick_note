part of 'reorder_note_block_cubit.dart';

class ReorderNoteBlockState extends Equatable {
  const ReorderNoteBlockState({
    List<NoteBlock>? initialBlocks,
    List<NoteBlock>? blocks,
  })  : initialBlocks = initialBlocks ?? const [],
        blocks = blocks ?? const [];

  final List<NoteBlock> initialBlocks;
  final List<NoteBlock> blocks;

  ReorderNoteBlockState copyWith({
    List<NoteBlock>? initialBlocks,
    List<NoteBlock>? blocks,
  }) {
    return ReorderNoteBlockState(
      blocks: blocks ?? this.blocks,
      initialBlocks: initialBlocks ?? this.initialBlocks,
    );
  }

  @override
  List<Object> get props => [initialBlocks, blocks];
}

final class ReorderNoteBlockInitial extends ReorderNoteBlockState {}
