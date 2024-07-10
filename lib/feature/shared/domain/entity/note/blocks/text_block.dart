import 'package:hive/hive.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

part 'text_block.g.dart';

@HiveType(typeId: 3)
class TextBlock extends NoteBlock {
  const TextBlock({
    required super.id,
    super.type = NoteBlockType.text,
    this.text = "",
  });

  @HiveField(20, defaultValue: "")
  final String text;

  @override
  List<Object?> get props => [id, type, text];
}
