import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';

part 'reorder_note_block_state.dart';

class ReorderNoteBlockCubit extends Cubit<ReorderNoteBlockState> {
  ReorderNoteBlockCubit({List<NoteBlock>? blocks})
      : super(ReorderNoteBlockState(
          initialBlocks: blocks,
          blocks: blocks,
        ));

  FutureOr<void> reorderNoteBlocks(int oldIndex, int newIndex) async {
    final noteBlocksLength = state.blocks.length;

    if (oldIndex < 0 ||
        oldIndex >= noteBlocksLength ||
        newIndex < 0 ||
        newIndex >= noteBlocksLength) {
      return;
    }

    List<NoteBlock> updatedblocks = List.from(state.blocks);
    final NoteBlock blockToMove = updatedblocks.removeAt(oldIndex);
    updatedblocks.insert(newIndex, blockToMove);

    emit(state.copyWith(blocks: updatedblocks));
  }
}
