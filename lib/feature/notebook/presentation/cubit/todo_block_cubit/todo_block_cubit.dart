import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/check_list_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo_block.dart';

part 'todo_block_state.dart';

class TodoBlockCubit extends Cubit<TodoBlockState> {
  TodoBlockCubit({TodoBlock? block}) : super(TodoBlockState(block: block));

  FutureOr<void> loadBlock(TodoBlock block) async {
    emit(state.copyWith(block: block));
  }

  FutureOr<void> addCheckbox() async {
    final updatedItems = List<ChecklistItem>.from(state.block.items)
      ..add(ChecklistItem(id: state.block.items.length));
    final updatedBlock = state.block.copyWith(items: updatedItems);
    emit(state.copyWith(block: updatedBlock));
  }

  FutureOr<void> toggleCheckbox(num checkboxId) async {
    final updatedItems = state.block.items.map((item) {
      if (item.id == checkboxId) {
        return item.copyWith(isChecked: !item.isChecked);
      }
      return item;
    }).toList();
    final updatedBlock = state.block.copyWith(items: updatedItems);
    emit(state.copyWith(block: updatedBlock));
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

    final updatedBlock = state.block.copyWith(showProgressBar: visible);
    emit(state.copyWith(block: updatedBlock));
  }
}
