import 'package:quick_note/feature/import-export/domain/entity/note_data_package.dart';
import 'package:quick_note/feature/shared/data/model/note/note.module.dart';

class NoteDataPackageModel extends NoteDataPackage {
  const NoteDataPackageModel({
    required super.notes,
    required super.creationDate,
    super.exportedBy = '',
    super.exportVersion = '',
    super.description = '',
  });

  @override
  List<Object?> get props =>
      [notes, creationDate, exportedBy, exportVersion, description];
}
