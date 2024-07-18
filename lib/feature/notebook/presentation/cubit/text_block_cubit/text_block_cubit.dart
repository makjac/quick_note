import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text_block.dart';

part 'text_block_state.dart';

class TextBlockCubit extends Cubit<TextBlockState> {
  TextBlockCubit({TextBlock? block}) : super(TextBlockState(block: block));

  FutureOr<void> loadNoteBlock(TextBlock block) {
    emit(state.copyWith(block: block));
  }

  Future<void> changeNoteText(String text) async {
    final updatedBlock = state.block.copyWith(text: text);
    emit(state.copyWith(block: updatedBlock));
  }

  Future<void> changeBlockTitle(String title) async {
    final updatedBlock = state.block.copyWith(title: title, hasTitle: true);
    emit(state.copyWith(block: updatedBlock));
  }
}
