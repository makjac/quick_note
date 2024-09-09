part of 'todo_block_cubit.dart';

class TodoBlockState extends Equatable {
  const TodoBlockState({TodoBlock? block, this.command})
      : block = block ?? const TodoBlock(id: -1, items: []);

  final TodoBlock block;
  final NotebookCommand? command;

  TodoBlockState copyWith({TodoBlock? block, NotebookCommand? command}) {
    return TodoBlockState(
      block: block ?? this.block,
      command: command,
    );
  }

  @override
  List<Object> get props => [block, command ?? -1];
}

class TodoBlockAddedNewTaskItem extends TodoBlockState {
  factory TodoBlockAddedNewTaskItem.fromState(
      TodoBlockState state, ChecklistItem item) {
    return TodoBlockAddedNewTaskItem(
      block: state.block,
      item: item,
    );
  }

  const TodoBlockAddedNewTaskItem({super.block, required this.item});

  final ChecklistItem item;

  @override
  List<Object> get props => [item];
}

final class TodoBlockInitial extends TodoBlockState {}
