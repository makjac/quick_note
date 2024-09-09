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
    this.hasMaxLineLimit = false,
    this.maxLines = 3,
  });

  @HiveField(20, defaultValue: "")
  final String text;

  @HiveField(29, defaultValue: false)
  final bool hasMaxLineLimit;

  @HiveField(30, defaultValue: 3)
  final int maxLines;

  TextBlock copyWith({
    num? id,
    String? title,
    bool? hasTitle,
    String? text,
    bool? hasMaxLineLimit,
    int? maxLines,
  }) {
    return TextBlock(
        id: id ?? this.id,
        title: title ?? this.title,
        hasTitle: hasTitle ?? this.hasTitle,
        text: text ?? this.text,
        type: type,
        hasMaxLineLimit: hasMaxLineLimit ?? this.hasMaxLineLimit,
        maxLines: maxLines ?? this.maxLines);
  }

  @override
  List<Object?> get props => [
        super.props,
        id,
        title,
        hasTitle,
        type,
        text,
        maxLines,
        hasMaxLineLimit,
      ];
}
