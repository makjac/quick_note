import 'package:equatable/equatable.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';
import 'package:hive/hive.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_colors.dart';

class Note extends Equatable {
  const Note({
    required this.id,
    required this.created,
    required this.modified,
    this.title = "",
    this.content = const [],
    this.archived = false,
    this.author,
    this.isStarred = false,
    this.color = NoteColors.color1,
  });

  @HiveField(0)
  final num id;
  @HiveField(10)
  final DateTime created;
  @HiveField(20)
  final DateTime modified;
  @HiveField(30, defaultValue: "")
  final String title;
  @HiveField(40, defaultValue: [])
  final List<NoteBlock> content;
  @HiveField(50, defaultValue: false)
  final bool archived;
  @HiveField(60, defaultValue: "")
  final String? author;
  @HiveField(70, defaultValue: false)
  final bool isStarred;
  @HiveField(81, defaultValue: NoteColors.color1)
  final NoteColors color;

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
        color,
      ];
}
