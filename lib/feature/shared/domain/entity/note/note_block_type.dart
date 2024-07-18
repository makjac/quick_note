import 'package:hive/hive.dart';

part 'note_block_type.g.dart';

@HiveType(typeId: 2)
enum NoteBlockType {
  @HiveField(0)
  text,
  @HiveField(10)
  todo,
  // image,
  // video,
  // audio,
  // attachment,
  // drawing,
  // link,
  // table,
  // quote,
  // seperator,
  // location,
}