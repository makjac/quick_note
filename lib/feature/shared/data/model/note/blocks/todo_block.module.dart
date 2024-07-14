// ignore_for_file: must_be_immutable, overridden_fields

import 'package:hive/hive.dart';
import 'package:quick_note/feature/shared/data/model/note/blocks/check_list_item.module.dart';
import 'package:quick_note/feature/shared/data/model/note/note_block.module.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

part 'todo_block.module.g.dart';

@HiveType(typeId: 4)
class TodoBlockModel extends TodoBlock implements NoteBlockModel {
  const TodoBlockModel({
    required super.id,
    super.type = NoteBlockType.todo,
    required this.items,
  }) : super(items: items);

  @override
  @HiveField(20, defaultValue: [])
  final List<ChecklistItemModel> items;

  factory TodoBlockModel.fromEntity(TodoBlock block) {
    return TodoBlockModel(
      id: block.id,
      items: block.items.map(ChecklistItemModel.fromEntity).toList(),
    );
  }

  @override
  List<Object?> get props => [super.props, items];
}
