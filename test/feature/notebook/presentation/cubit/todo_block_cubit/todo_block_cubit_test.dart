import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quick_note/feature/notebook/domain/command/todo_block_command/todo_block_change_title_command.dart';
import 'package:quick_note/feature/notebook/domain/command/todo_block_command/todo_block_remove_task_command.dart';
import 'package:quick_note/feature/notebook/domain/command/todo_block_command/todo_block_reorder_tasks_command.dart';
import 'package:quick_note/feature/notebook/domain/command/todo_block_command/todo_block_title_visibility_command.dart';
import 'package:quick_note/feature/notebook/domain/command/todo_block_command/todo_block_toggle_hide_complete_tasks_command.dart';
import 'package:quick_note/feature/notebook/domain/command/todo_block_command/todo_block_toggle_show_progress_bar_command.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/feature/notebook/presentation/cubit/todo_block_cubit/todo_block_cubit.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/check_list_item.dart';

class MockNotebookBloc extends Mock implements NotebookBloc {}

void main() {
  group(
    'TodoBlockCubit',
    () {
    late TodoBlockCubit cubit;
      late NotebookBloc mockNotebookBloc;

    setUp(() {
        mockNotebookBloc = MockNotebookBloc();

        when(() => mockNotebookBloc.stream)
            .thenAnswer((_) => const Stream<NotebookState>.empty());

      const initialBlock = TodoBlock(
        id: 1,
        items: [
          ChecklistItem(id: 1, title: 'Item 1', isChecked: false),
          ChecklistItem(id: 2, title: 'Item 2', isChecked: true),
        ],
      );
      cubit = TodoBlockCubit(
block: initialBlock,
          notebookBloc: mockNotebookBloc,
);
    });

    test('initial state is correct', () {
      expect(
          cubit.state,
          equals(const TodoBlockState(
              block: TodoBlock(
            id: 1,
            items: [
              ChecklistItem(id: 1, title: 'Item 1', isChecked: false),
              ChecklistItem(id: 2, title: 'Item 2', isChecked: true),
            ],
          ))));
    });

    blocTest<TodoBlockCubit, TodoBlockState>(
      'loadBlock updates the block',
      build: () => cubit,
      act: (cubit) => cubit.loadBlock(
        const TodoBlock(
          id: 2,
          items: [ChecklistItem(id: 3, title: 'New Item', isChecked: false)],
        ),
      ),
      expect: () => [
        const TodoBlockState(
          block: TodoBlock(
            id: 2,
              items: [
                ChecklistItem(id: 3, title: 'New Item', isChecked: false)
              ],
          ),
        ),
      ],
    );

    blocTest<TodoBlockCubit, TodoBlockState>(
      'addCheckbox adds a new checkbox',
      build: () => cubit,
      act: (cubit) => cubit.addCheckbox(),
      expect: () => [
        const TodoBlockAddedNewTaskItem(
          block: TodoBlock(
            id: 1,
            items: [
              ChecklistItem(id: 1, title: 'Item 1', isChecked: false),
              ChecklistItem(id: 2, title: 'Item 2', isChecked: true),
              ChecklistItem(id: 3, title: '', isChecked: false),
            ],
          ),
          item: ChecklistItem(id: 3, title: '', isChecked: false),
        ),
      ],
    );

    blocTest<TodoBlockCubit, TodoBlockState>(
      'toggleCheckbox toggles checkbox status',
      build: () => cubit,
      act: (cubit) => cubit.toggleCheckbox(1),
      expect: () => [
          isA<TodoBlockState>()
              .having((state) => state.block.items[0].isChecked,
                  'first item isChecked', true)
              .having((state) => 1, 'taskId', 1),
      ],
    );

    blocTest<TodoBlockCubit, TodoBlockState>(
      'changeCheckboxName updates checkbox title',
      build: () => cubit,
      act: (cubit) => cubit.changeCheckboxName(1, 'Updated Item 1'),
      expect: () => [
        const TodoBlockState(
          block: TodoBlock(
            id: 1,
            items: [
              ChecklistItem(id: 1, title: 'Updated Item 1', isChecked: false),
              ChecklistItem(id: 2, title: 'Item 2', isChecked: true),
            ],
          ),
        ),
      ],
    );

    blocTest<TodoBlockCubit, TodoBlockState>(
      'removeCheckbox removes a checkbox',
      build: () => cubit,
      act: (cubit) => cubit.removeCheckbox(1),
      expect: () => [
        const TodoBlockState(
          block: TodoBlock(
            id: 1,
            items: [
              ChecklistItem(id: 2, title: 'Item 2', isChecked: true),
            ],
          ),
        ),
      ],
    );

    blocTest<TodoBlockCubit, TodoBlockState>(
      'changeCheckboxOrder updates checkbox order',
      build: () => cubit,
      act: (cubit) => cubit.changeCheckboxOrder(0, 1),
      expect: () => [
        const TodoBlockState(
          block: TodoBlock(
            id: 1,
            items: [
              ChecklistItem(id: 2, title: 'Item 2', isChecked: true),
              ChecklistItem(id: 1, title: 'Item 1', isChecked: false),
            ],
          ),
        ),
      ],
    );

    blocTest<TodoBlockCubit, TodoBlockState>(
      'changeBlockTitle updates block title',
      build: () => cubit,
      act: (cubit) => cubit.changeBlockTitle('New Title'),
      expect: () => [
        const TodoBlockState(
          block: TodoBlock(
            id: 1,
            items: [
              ChecklistItem(id: 1, title: 'Item 1', isChecked: false),
              ChecklistItem(id: 2, title: 'Item 2', isChecked: true),
            ],
            title: 'New Title',
          ),
        ),
      ],
    );

    blocTest<TodoBlockCubit, TodoBlockState>(
      'changeBlockTitleVisibility updates block title visibility',
      build: () => cubit,
      act: (cubit) => cubit.changeBlockTitleVisibility(false),
      expect: () => [
        const TodoBlockState(
          block: TodoBlock(
            id: 1,
            items: [
              ChecklistItem(id: 1, title: 'Item 1', isChecked: false),
              ChecklistItem(id: 2, title: 'Item 2', isChecked: true),
            ],
            hasTitle: false,
          ),
        ),
      ],
    );

    blocTest<TodoBlockCubit, TodoBlockState>(
      'changeBlockCompleteTasksVisibility updates block complete tasks visibility',
      build: () => cubit,
      act: (cubit) => cubit.changeBlockCompleteTasksVisibility(true),
      expect: () => [
        const TodoBlockState(
          block: TodoBlock(
            id: 1,
            items: [
              ChecklistItem(id: 1, title: 'Item 1', isChecked: false),
              ChecklistItem(id: 2, title: 'Item 2', isChecked: true),
            ],
            showCompleteTasks: true,
          ),
        ),
      ],
    );

    blocTest<TodoBlockCubit, TodoBlockState>(
      'changeBlockProgressBarVisibility updates block progress bar visibility',
      build: () => cubit,
      act: (cubit) => cubit.changeBlockProgressBarVisibility(true),
      expect: () => [
        const TodoBlockState(
          block: TodoBlock(
            id: 1,
            items: [
              ChecklistItem(id: 1, title: 'Item 1', isChecked: false),
              ChecklistItem(id: 2, title: 'Item 2', isChecked: true),
            ],
            showProgressBar: true,
          ),
        ),
      ],
    );
  });
}
