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

  NoteDataPackageModel copyWith({
    List<NoteModel>? notes,
    DateTime? creationDate,
    String? exportedBy,
    String? exportVersion,
    String? description,
  }) {
    return NoteDataPackageModel(
      notes: notes ?? this.notes,
      creationDate: creationDate ?? this.creationDate,
      exportedBy: exportedBy ?? this.exportedBy,
      exportVersion: exportVersion ?? this.exportVersion,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notes':
          notes.map((note) => NoteModel.fromEntity(note).toJson()).toList(),
      'creationDate': creationDate.toIso8601String(),
      'exportedBy': exportedBy,
      'exportVersion': exportVersion,
      'description': description,
    };
  }

  @override
  List<Object?> get props =>
      [notes, creationDate, exportedBy, exportVersion, description];
}
