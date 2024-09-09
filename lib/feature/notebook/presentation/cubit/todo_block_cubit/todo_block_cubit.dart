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
    final updatedItems = state.block.items.map((item) {
      if (item.id == checkboxId) {
        return item.copyWith(title: name);
      }
      return item;
    }).toList();
    final updatedBlock = state.block.copyWith(items: updatedItems);
    emit(state.copyWith(block: updatedBlock));
  }

  FutureOr<void> removeCheckbox(num checkboxId) async {
    final updatedItems =
        state.block.items.where((item) => item.id != checkboxId).toList();
    final updatedBlock = state.block.copyWith(items: updatedItems);
    emit(state.copyWith(block: updatedBlock));
  }

  FutureOr<void> changeCheckboxOrder(int oldIndex, int newIndex) async {
    if (oldIndex < 0 ||
        oldIndex >= state.block.items.length ||
        newIndex < 0 ||
        newIndex >= state.block.items.length) {
      return;
    }
    final updatedItems = List<ChecklistItem>.from(state.block.items);
    final item = updatedItems.removeAt(oldIndex);
    updatedItems.insert(newIndex, item);
    final updatedBlock = state.block.copyWith(items: updatedItems);
    emit(state.copyWith(block: updatedBlock));
  }

  FutureOr<void> changeBlockTitle(String title) async {
    final updatedBlock = state.block.copyWith(title: title);
    emit(state.copyWith(block: updatedBlock));
  }

  Future<void> changeBlockTitleVisibility(bool? visible) async {
    if (visible == null) return;

    final updatedBlock = state.block.copyWith(hasTitle: visible);
    emit(state.copyWith(block: updatedBlock));
  }

  Future<void> changeBlockCompleteTasksVisibility(bool? visible) async {
    if (visible == null) return;

    final updatedBlock = state.block.copyWith(showCompleteTasks: visible);
    emit(state.copyWith(block: updatedBlock));
  }

  Future<void> changeBlockProgressBarVisibility(bool? visible) async {
    if (visible == null) return;

  @override
  Future<void> close() {
    notebookBlocSubscription?.cancel();
    return super.close();
  }
}
