// ignore_for_file: must_be_immutable

import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/shared/data/model/note/note_block.module.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:hive/hive.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';

part 'note.module.g.dart';

@HiveType(typeId: 0)
class NoteModel extends Note with HiveObjectMixin {
  NoteModel({
    required super.id,
    required super.created,
    required super.modified,
    required super.title,
    required super.content,
    super.archived,
    super.author,
    super.isStarred,
    super.colorHex,
  });

  factory NoteModel.fromEntity(Note entity) {
    return NoteModel(
      id: entity.id,
      created: entity.created,
      modified: entity.modified,
      title: entity.title,
      content: entity.content.map(NoteBlockModel.fromEntity).toList(),
      archived: entity.archived,
      author: entity.author,
      isStarred: entity.isStarred,
      colorHex: entity.colorHex,
    );
  }

  factory NoteModel.updateEntity(Note entity, NoteUpdates updates) {
    return NoteModel(
      id: entity.id,
      created: entity.created,
      modified: updates.modified ?? entity.modified,
      title: updates.title ?? entity.title,
      content: updates.content?.map(NoteBlockModel.fromEntity).toList() ??
          entity.content.map(NoteBlockModel.fromEntity).toList(),
      archived: updates.archived ?? entity.archived,
      author: updates.author ?? entity.author,
      isStarred: updates.isStarred ?? entity.isStarred,
      colorHex: updates.colorHex ?? entity.colorHex,
    );
  }

  Note toEntity() {
    return Note(
      id: id,
      created: created,
      modified: modified,
      title: title,
      archived: archived,
      author: author,
      colorHex: colorHex,
      isStarred: isStarred,
      content: content,
    );
  }

  @override
  List<Object?> get props => [
        id,
        created,
        modified,
        title,
        content,
        archived,
        author,
        isStarred,
        colorHex,
      ];
}
