import 'package:equatable/equatable.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';
import 'package:hive/hive.dart';

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
    this.colorHex = "ffa600",
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
  @HiveField(80, defaultValue: "ffa600")
  final String colorHex;

  @override
  List<Object?> get props => throw UnimplementedError();
}
