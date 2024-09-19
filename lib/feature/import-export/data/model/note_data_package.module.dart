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
  factory NoteDataPackageModel.fromEntity(NoteDataPackage data) {
    return NoteDataPackageModel(
      notes: data.notes,
      creationDate: data.creationDate,
      exportedBy: data.exportedBy,
      exportVersion: data.exportVersion,
      description: data.description,
    );
  }

  factory NoteDataPackageModel.fromJson(Map<String, dynamic> json) {
    return NoteDataPackageModel(
      notes: (json['notes'] as List)
          .map((note) => NoteModel.fromJson(note))
          .toList(),
      creationDate: DateTime.parse(json['creationDate']),
      exportedBy: json['exportedBy'],
      exportVersion: json['exportVersion'],
      description: json['description'],
    );
  }


  @override
  List<Object?> get props =>
      [notes, creationDate, exportedBy, exportVersion, description];
}
