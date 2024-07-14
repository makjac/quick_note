// ignore_for_file: must_be_immutable

import 'package:quick_note/feature/shared/data/model/note/blocks/text_block.module.dart';
import 'package:quick_note/feature/shared/data/model/note/blocks/todo_block.module.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';

abstract class NoteBlockModel extends NoteBlock {
  const NoteBlockModel({required super.id, required super.type});

  factory NoteBlockModel.fromEntity(NoteBlock block) {
    if (block is TextBlock) {
      return TextBlockModel.fromEntity(block);
    } else if (block is TodoBlock) {
      return TodoBlockModel.fromEntity(block);
    } else {
      throw UnimplementedError();
    }
  }

  @override
  List<Object?> get props => [id, type];
}
