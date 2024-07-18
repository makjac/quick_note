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

final class TodoBlockInitial extends TodoBlockState {}
