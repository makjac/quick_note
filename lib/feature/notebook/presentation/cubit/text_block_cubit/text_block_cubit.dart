import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';

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

  Future<void> changeBlockTitleVisibility(bool? visibility) async {
    if (visibility == null) return;

    final updatedBlock = state.block.copyWith(hasTitle: visibility);
    emit(state.copyWith(block: updatedBlock));
  }

  Future<void> setMaxLinesLimitOption(bool? isEnabled) async {
    if (isEnabled == null) return;

    final updatedBlock = state.block.copyWith(hasMaxLineLimit: isEnabled);
    emit(state.copyWith(block: updatedBlock));
  }

  Future<void> setTextLinecountLimit(int? limit) async {
    final updatedBlock = state.block.copyWith(maxLines: limit);
    emit(state.copyWith(block: updatedBlock));
  }
}
