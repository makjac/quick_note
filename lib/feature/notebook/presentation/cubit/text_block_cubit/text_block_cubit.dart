import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/notebook/domain/command/text_block_command/text_block_change_note_text_command.dart';
import 'package:quick_note/feature/notebook/domain/command/text_block_command/text_block_change_title_command.dart';
import 'package:quick_note/feature/notebook/domain/command/text_block_command/text_block_set_text_line_limit_command.dart';
import 'package:quick_note/feature/notebook/domain/command/text_block_command/text_block_title_visibility_command.dart';
import 'package:quick_note/feature/notebook/domain/command/text_block_command/text_block_toggle_lines_limit_command.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';

part 'text_block_state.dart';

class TextBlockCubit extends Cubit<TextBlockState> {
  TextBlockCubit({required NotebookBloc notebookBloc, TextBlock? block})
      : super(TextBlockState(block: block)) {
    notebookBlocSubscription = notebookBloc.stream.listen((notebookState) {
      if (notebookState is NotebookNoteBlockCommand) {
        if (notebookState.command.type != NotebookCommandType.text) return;
        if (notebookState.command.ownerId != state.block.id) return;
        if (notebookState.isUndo) {
          undo(notebookState.command);
        } else {
          redo(notebookState.command);
        }
      }
    });
  }

  StreamSubscription<NotebookState>? notebookBlocSubscription;

  FutureOr<void> loadNoteBlock(TextBlock block) {
    emit(state.copyWith(block: block));
  }

  Future<void> changeNoteText(String text) async {
    final command = TextBlockChangeNoteTextCommand(
      block: state.block,
      newNoteText: text,
    );

    final updatedBlock = command.execute();
    emit(state.copyWith(block: updatedBlock, command: command));
  }

  Future<void> changeBlockTitle(String title) async {
    final command = TextBlockChangeTitleCommand(
      block: state.block,
      newTitle: title,
    );

    final updatedBlock = command.execute();
    emit(state.copyWith(block: updatedBlock, command: command));
  }

  Future<void> changeBlockTitleVisibility(bool? visibility) async {
    if (visibility == null) return;

    final command = TextBlockTitleVisibilityCommand(
      block: state.block,
      newTitleVisibility: visibility,
    );

    final updatedBlock = command.execute();
    emit(state.copyWith(block: updatedBlock, command: command));
  }

  Future<void> setMaxLinesLimitOption(bool? isEnabled) async {
    if (isEnabled == null) return;

    final command = TextBlockToggleLinesLimitCommand(
      block: state.block,
      newHasLinesLimit: isEnabled,
    );

    final updatedBlock = command.execute();
    emit(state.copyWith(block: updatedBlock, command: command));
  }

  Future<void> setTextLinecountLimit(int? limit) async {
    final updatedBlock = state.block.copyWith(maxLines: limit);
    emit(state.copyWith(block: updatedBlock));
  }
}
