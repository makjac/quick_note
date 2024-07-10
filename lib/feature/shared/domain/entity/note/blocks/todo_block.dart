import 'package:hive/hive.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/check_list_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

part 'todo_block.g.dart';

@HiveType(typeId: 4)
class TodoBlock extends NoteBlock {
  const TodoBlock({
    required super.id,
    super.type = NoteBlockType.todo,
    required this.items,
  });

  @HiveField(20, defaultValue: [])
  final List<ChecklistItem> items;
}
