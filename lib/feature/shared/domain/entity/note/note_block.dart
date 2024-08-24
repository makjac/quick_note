import 'package:equatable/equatable.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';
import 'package:hive/hive.dart';

abstract class NoteBlock extends Equatable {
  const NoteBlock(
      {required this.id,
      this.title = "",
      this.hasTitle = false,
      required this.type});

  @HiveField(0)
  final num id;
  @HiveField(1, defaultValue: "")
  final String title;
  @HiveField(2, defaultValue: false)
  final bool hasTitle;
  @HiveField(10)
  final NoteBlockType type;

  @override
  List<Object?> get props => [id, title, hasTitle, type];
}
