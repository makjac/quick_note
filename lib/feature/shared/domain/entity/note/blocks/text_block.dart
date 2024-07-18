import 'package:hive/hive.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

class TextBlock extends NoteBlock {
  const TextBlock({
    required super.id,
    super.title = "",
    super.hasTitle = false,
    super.type = NoteBlockType.text,
    this.text = "",
  });

  @HiveField(20, defaultValue: "")
  final String text;

  TextBlock copyWith({
    num? id,
    String? title,
    bool? hasTitle,
    String? text,
  }) {
    return TextBlock(
      id: id ?? this.id,
      title: title ?? this.title,
      hasTitle: hasTitle ?? this.hasTitle,
      text: text ?? this.text,
      type: type,
    );
  }

  @override
  List<Object?> get props => [id, title, hasTitle, type, text];
}
