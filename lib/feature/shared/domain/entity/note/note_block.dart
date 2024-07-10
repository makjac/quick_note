import 'package:equatable/equatable.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';
import 'package:hive/hive.dart';

abstract class NoteBlock extends Equatable {
  const NoteBlock({required this.id, required this.type});

  @HiveField(0)
  final num id;
  @HiveField(10)
  final NoteBlockType type;

  @override
  List<Object?> get props => [];
}
