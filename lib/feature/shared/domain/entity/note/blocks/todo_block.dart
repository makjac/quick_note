import 'package:quick_note/feature/shared/domain/entity/note/blocks/check_list_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

class TodoBlock extends NoteBlock {
  const TodoBlock({
    required super.id,
    super.title = "",
    super.hasTitle = false,
    super.type = NoteBlockType.todo,
    required this.items,
  });

  final List<ChecklistItem> items;

  TodoBlock copyWith({
    num? id,
    String? title,
    bool? hasTitle,
    List<ChecklistItem>? items,
  }) {
    return TodoBlock(
      id: id ?? this.id,
      title: title ?? this.title,
      hasTitle: hasTitle ?? this.hasTitle,
      items: items ?? this.items,
      type: type,
    );
  }

  @override
  List<Object?> get props => [id, title, hasTitle, type, items];
}
