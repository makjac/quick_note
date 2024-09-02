part of 'todo_block_cubit.dart';

class TodoBlockState extends Equatable {
  const TodoBlockState({TodoBlock? block})
      : block = block ?? const TodoBlock(id: -1, items: []);

  final TodoBlock block;

  TodoBlockState copyWith({TodoBlock? block}) {
    return TodoBlockState(
      block: block ?? this.block,
    );
  }

  @override
  List<Object> get props => [block];
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
