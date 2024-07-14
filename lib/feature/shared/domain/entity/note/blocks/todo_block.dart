import 'package:quick_note/feature/shared/domain/entity/note/blocks/check_list_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

class TodoBlock extends NoteBlock {
  const TodoBlock({
    required super.id,
    super.type = NoteBlockType.todo,
    required this.items,
  });

  final List<ChecklistItem> items;
}
