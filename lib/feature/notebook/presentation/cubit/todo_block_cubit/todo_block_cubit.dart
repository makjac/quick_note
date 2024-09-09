import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/notebook/domain/command/todo_block_command/todo_block_add_task_command.dart';
import 'package:quick_note/feature/notebook/domain/command/todo_block_command/todo_block_change_title_command.dart';
import 'package:quick_note/feature/notebook/domain/command/todo_block_command/todo_block_remove_task_command.dart';
import 'package:quick_note/feature/notebook/domain/command/todo_block_command/todo_block_rename_task_command.dart';
import 'package:quick_note/feature/notebook/domain/command/todo_block_command/todo_block_reorder_tasks_command.dart';
import 'package:quick_note/feature/notebook/domain/command/todo_block_command/todo_block_title_visibility_command.dart';
import 'package:quick_note/feature/notebook/domain/command/todo_block_command/todo_block_toggle_hide_complete_tasks_command.dart';
import 'package:quick_note/feature/notebook/domain/command/todo_block_command/todo_block_toggle_show_progress_bar_command.dart';
import 'package:quick_note/feature/notebook/domain/command/todo_block_command/todo_block_toggle_task_command.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/check_list_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';

part 'todo_block_state.dart';

class TodoBlockCubit extends Cubit<TodoBlockState> {
  TodoBlockCubit({required NotebookBloc notebookBloc, TodoBlock? block})
      : super(TodoBlockState(block: block)) {
    notebookBlocSubscription = notebookBloc.stream.listen((notebookState) {
      if (notebookState is NotebookNoteBlockCommand) {
        if (notebookState.command.type != NotebookCommandType.todo) return;
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

  FutureOr<void> loadBlock(TodoBlock block) async {
    emit(state.copyWith(block: block));
  }

  FutureOr<void> addCheckbox() async {
    final maxId = state.block.items.isNotEmpty
        ? state.block.items
            .map((item) => item.id)
            .reduce((a, b) => a > b ? a : b)
        : 0;

    final newTaskItem = ChecklistItem(id: maxId + 1);

    final command =
        TodoBlockAddTaskCommand(block: state.block, newTaskItem: newTaskItem);

    final updatedBlock = command.execute();

    emit(TodoBlockAddedNewTaskItem.fromState(
      state.copyWith(block: updatedBlock, command: command),
      newTaskItem,
    ));
  }

  FutureOr<void> toggleCheckbox(num checkboxId) async {
    final command =
        TodoBlockToggleTaskCommand(block: state.block, taskId: checkboxId);

    final updatedBlock = command.execute();

    emit(state.copyWith(block: updatedBlock, command: command));
  }

  FutureOr<void> changeCheckboxName(num checkboxId, String name) async {
    final command = TodoBlockRenameTaskCommand(
      block: state.block,
      taskId: checkboxId,
      newTaskName: name,
    );

    final updatedBlock = command.execute();

    emit(state.copyWith(block: updatedBlock, command: command));
  }

  FutureOr<void> removeCheckbox(num checkboxId) async {
    final command = TodoBlockRemoveTaskCommand(
      block: state.block,
      taskId: checkboxId,
    );

    final updatedBlock = command.execute();

    emit(state.copyWith(block: updatedBlock, command: command));
  }

  FutureOr<void> changeCheckboxOrder(int oldIndex, int newIndex) async {
    final command = TodoBlockReorderTasksCommand(
      block: state.block,
      oldIndex: oldIndex,
      newIndex: newIndex,
    );

    final updatedBlock = command.execute();

    emit(state.copyWith(block: updatedBlock, command: command));
  }

  FutureOr<void> changeBlockTitle(String title) async {
    final command = TodoBlockChangeTitleCommand(
      block: state.block,
      newTitle: title,
    );

    final updatedBlock = command.execute();

    emit(state.copyWith(block: updatedBlock, command: command));
  }

  Future<void> changeBlockTitleVisibility(bool? visible) async {
    if (visible == null) return;

    final command = TodoBlockTitleVisibilityCommand(
      block: state.block,
      isVisible: visible,
    );

    final updatedBlock = command.execute();

    emit(state.copyWith(block: updatedBlock, command: command));
  }

  Future<void> changeBlockCompleteTasksVisibility(bool? visible) async {
    if (visible == null) return;

    final command = TodoBlockToggleHideCompleteTasksCommand(
      block: state.block,
      isVisible: visible,
    );

    final updatedBlock = command.execute();

    emit(state.copyWith(block: updatedBlock, command: command));
  }

  Future<void> changeBlockProgressBarVisibility(bool? visible) async {
    if (visible == null) return;

    final command = TodoBlockToggleShowProgressBarCommand(
      block: state.block,
      isVisible: visible,
    );

    final updatedBlock = command.execute();

    emit(state.copyWith(block: updatedBlock, command: command));
  }
  @override
  Future<void> close() {
    notebookBlocSubscription?.cancel();
    return super.close();
  }
}
