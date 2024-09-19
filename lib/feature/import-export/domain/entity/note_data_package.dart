import 'package:equatable/equatable.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

class NoteDataPackage extends Equatable {
  const NoteDataPackage({
    required this.notes,
    required this.creationDate,
    this.exportedBy = '',
    this.exportVersion = '',
    this.description = '',
  });

  final List<Note> notes;

  final DateTime creationDate;

  final String exportedBy;

  final String exportVersion;

  final String description;

  @override
  List<Object?> get props =>
      [notes, creationDate, exportedBy, exportVersion, description];
}
