// ignore_for_file: must_be_immutable, overridden_fields

import 'package:hive/hive.dart';
import 'package:quick_note/feature/shared/data/model/note/blocks/todo/check_list_item.module.dart';
import 'package:quick_note/feature/shared/data/model/note/note_block.module.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

part 'todo_block.module.g.dart';

@HiveType(typeId: 4)
class TodoBlockModel extends TodoBlock implements NoteBlockModel {
  factory TodoBlockModel.fromEntity(TodoBlock block) {
    return TodoBlockModel(
      id: block.id,
      title: block.title,
      hasTitle: block.hasTitle,
      items: block.items.map(ChecklistItemModel.fromEntity).toList(),
      showCompleteTasks: block.showCompleteTasks,
      showProgressBar: block.showProgressBar,
      maxVisibleTasks: block.maxVisibleTasks,
      dedline: block.dedline,
    );
  }

  const TodoBlockModel({
    required super.id,
    super.title = "",
    super.hasTitle = false,
    super.type = NoteBlockType.todo,
    required this.items,
    super.showCompleteTasks = false,
    super.showProgressBar = false,
    super.maxVisibleTasks,
    super.dedline,
  }) : super(items: items);

  @override
  @HiveField(20, defaultValue: [])
  final List<ChecklistItemModel> items;

  @override
  List<Object?> get props => [
        super.props,
        title,
        hasTitle,
        items,
        type,
      ];
}
