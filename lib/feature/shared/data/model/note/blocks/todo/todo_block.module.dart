// ignore_for_file: must_be_immutable, overridden_fields

import 'package:hive/hive.dart';
import 'package:quick_note/feature/shared/data/model/note/blocks/todo/check_list_item.module.dart';
import 'package:quick_note/feature/shared/data/model/note/note_block.module.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

part 'todo_block.module.g.dart';

@HiveType(typeId: 4)
class TodoBlockModel extends TodoBlock implements NoteBlockModel {
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

  factory TodoBlockModel.fromEntity(TodoBlock block) {
    return TodoBlockModel(
      id: block.id,
      title: block.title,
      hasTitle: block.hasTitle,
      type: block.type,
      items: block.items.map(ChecklistItemModel.fromEntity).toList(),
      showCompleteTasks: block.showCompleteTasks,
      showProgressBar: block.showProgressBar,
      maxVisibleTasks: block.maxVisibleTasks,
      dedline: block.dedline,
    );
  }

  factory TodoBlockModel.fromJson(Map<String, dynamic> json) {
    return TodoBlockModel(
      id: json['id'] as num,
      title: json['title'] as String? ?? "",
      hasTitle: json['hasTitle'] as bool? ?? false,
      type: NoteBlockType.values[json['type'] as int],
      items: (json['items'] as List<dynamic>)
          .map((item) =>
              ChecklistItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      showCompleteTasks: json['showCompleteTasks'] as bool? ?? false,
      showProgressBar: json['showProgressBar'] as bool? ?? false,
      maxVisibleTasks: json['maxVisibleTasks'] as int?,
      dedline: DateTime.tryParse(json['dedline'] as String? ?? ""),
    );
  }

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
