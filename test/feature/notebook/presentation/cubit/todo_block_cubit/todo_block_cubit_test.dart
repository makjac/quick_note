import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/presentation/cubit/todo_block_cubit/todo_block_cubit.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/check_list_item.dart';

void main() {
  group('TodoBlockCubit', () {
    late TodoBlockCubit cubit;

    setUp(() {
      const initialBlock = TodoBlock(
        id: 1,
        items: [
          ChecklistItem(id: 1, title: 'Item 1', isChecked: false),
          ChecklistItem(id: 2, title: 'Item 2', isChecked: true),
        ],
      );
      cubit = TodoBlockCubit(block: initialBlock);
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
            items: [ChecklistItem(id: 3, title: 'New Item', isChecked: false)],
          ),
        ),
      ],
    );

    blocTest<TodoBlockCubit, TodoBlockState>(
      'addCheckbox adds a new checkbox',
      build: () => cubit,
      act: (cubit) => cubit.addCheckbox(),
      expect: () => [
        const TodoBlockState(
          block: TodoBlock(
            id: 1,
            items: [
              ChecklistItem(id: 1, title: 'Item 1', isChecked: false),
              ChecklistItem(id: 2, title: 'Item 2', isChecked: true),
              ChecklistItem(id: 3, title: '', isChecked: false),
            ],
          ),
        ),
      ],
    );

    blocTest<TodoBlockCubit, TodoBlockState>(
      'toggleCheckbox toggles checkbox status',
      build: () => cubit,
      act: (cubit) => cubit.toggleCheckbox(1),
      expect: () => [
        const TodoBlockState(
          block: TodoBlock(
            id: 1,
            items: [
              ChecklistItem(id: 1, title: 'Item 1', isChecked: true),
              ChecklistItem(id: 2, title: 'Item 2', isChecked: true),
            ],
          ),
        ),
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
