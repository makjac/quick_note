import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/feature/notebook/presentation/cubit/todo_block_cubit/todo_block_cubit.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo_block.dart';

Future<void> showTodoBlockSettingsDialog(
    BuildContext context, TodoBlock block) async {
  return showDialog<void>(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: const Text("Todo block settings"),
        content: BlocBuilder<TodoBlockCubit, TodoBlockState>(
          bloc: BlocProvider.of<TodoBlockCubit>(context),
          builder: (_, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CheckboxListTile(
                  value: state.block.hasTitle,
                  onChanged: (value) => BlocProvider.of<TodoBlockCubit>(context)
                      .changeBlockTitleVisibility(value),
                  title: const Text("Show block title"),
                ),
                CheckboxListTile(
                  value: state.block.showCompleteTasks,
                  onChanged: (value) => BlocProvider.of<TodoBlockCubit>(context)
                      .changeBlockCompleteTasksVisibility(value),
                  title: const Text("Hide complete tasks"),
                ),
                CheckboxListTile(
                  value: state.block.showProgressBar,
                  onChanged: (value) => BlocProvider.of<TodoBlockCubit>(context)
                      .changeBlockProgressBarVisibility(value),
                  title: const Text("Show progress bar"),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
