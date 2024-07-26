// ignore_for_file: must_be_immutable

import 'package:hive/hive.dart';
import 'package:quick_note/feature/shared/data/model/note/note_block.module.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

part 'text_block.module.g.dart';

@HiveType(typeId: 3)
class TextBlockModel extends TextBlock implements NoteBlockModel {
  const TextBlockModel({
    required super.id,
    super.title = "",
    super.hasTitle = false,
    super.type = NoteBlockType.text,
    super.text = "",
    super.hasMaxLineLimit = false,
    super.maxLines = 3,
  });

  factory TextBlockModel.fromEntity(TextBlock block) {
    return TextBlockModel(
      id: block.id,
      title: block.title,
      hasTitle: block.hasTitle,
      text: block.text,
      hasMaxLineLimit: block.hasMaxLineLimit,
      maxLines: block.maxLines,
    );
  }

  @override
  List<Object?> get props => [
        super.props,
        title,
        hasTitle,
        text,
        type,
        hasMaxLineLimit,
        maxLines,
      ];
}
