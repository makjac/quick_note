// ignore_for_file: must_be_immutable

import 'package:quick_note/feature/shared/data/model/note/blocks/bookmarks/bookmarks_block.module.dart';
import 'package:quick_note/feature/shared/data/model/note/blocks/text/text_block.module.dart';
import 'package:quick_note/feature/shared/data/model/note/blocks/todo/todo_block.module.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

abstract class NoteBlockModel extends NoteBlock {
  const NoteBlockModel({
    required super.id,
    super.title = "",
    super.hasTitle = true,
    required super.type,
  });

  factory NoteBlockModel.fromEntity(NoteBlock block) {
    if (block is TextBlock) {
      return TextBlockModel.fromEntity(block);
    } else if (block is TodoBlock) {
      return TodoBlockModel.fromEntity(block);
    } else if (block is BookmarksBlock) {
      return BookmarksBlockModel.fromEntity(block);
    } else {
      throw UnimplementedError();
    }
  }

  factory NoteBlockModel.fromJson(Map<String, dynamic> json) {
    final type = NoteBlockType.values[json['type'] as int];
    switch (type) {
      case NoteBlockType.text:
        return TextBlockModel.fromJson(json);
      case NoteBlockType.todo:
        return TodoBlockModel.fromJson(json);
      case NoteBlockType.bookmarks:
        return BookmarksBlockModel.fromJson(json);
      default:
        throw UnimplementedError();
    }
  }

  @override
  List<Object?> get props => [id, title, hasTitle, type];
}
