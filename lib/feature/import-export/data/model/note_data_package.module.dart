import 'package:quick_note/feature/import-export/domain/entity/note_data_package.dart';
import 'package:quick_note/feature/shared/data/model/note/note.module.dart';

/// A model class for representing a package of notes, extending the [NoteDataPackage] entity.
///
/// This class provides a model layer implementation for handling note data,
/// including serialization and deserialization from JSON, as well as converting
/// between entity and model representations. It also supports creating a copy of
/// the model with optional modifications.
///
/// **Inheritance:**
/// - Extends: [NoteDataPackage]
///
/// **Properties:**
/// - `notes`: A list of [NoteModel] objects representing the notes included in the package.
/// - `creationDate`: The date and time when the notes package was created.
/// - `exportedBy`: The name or identifier of the person or system that performed the export.
/// - `exportVersion`: The version of the export process or application used.
/// - `description`: An optional description providing additional context or metadata about the export.
///
/// **Methods:**
/// - `fromEntity`: Creates a [NoteDataPackageModel] instance from a [NoteDataPackage] entity.
/// - `fromJson`: Creates a [NoteDataPackageModel] instance from a JSON map.
/// - `copyWith`: Creates a copy of the model with optional modifications.
/// - `toJson`: Converts the model to a JSON map.
///
/// **Usage Example:**
/// ```dart
/// // Creating an instance from an entity
/// final noteDataPackage = NoteDataPackage(
///   notes: [NoteModel(title: 'Note 1', content: 'Content 1')],
///   creationDate: DateTime.now(),
///   exportedBy: 'John Doe',
///   exportVersion: '1.0',
///   description: 'Exported notes for project X',
/// );
/// final noteDataPackageModel = NoteDataPackageModel.fromEntity(noteDataPackage);
///
/// // Creating an instance from JSON
/// final json = {
///   'notes': [{'title': 'Note 1', 'content': 'Content 1'}],
///   'creationDate': DateTime.now().toIso8601String(),
///   'exportedBy': 'John Doe',
///   'exportVersion': '1.0',
///   'description': 'Exported notes for project X',
/// };
/// final noteDataPackageModelFromJson = NoteDataPackageModel.fromJson(json);
///
/// // Creating a copy with modifications
/// final updatedModel = noteDataPackageModel.copyWith(
///   description: 'Updated description',
/// );
///
/// // Converting model to JSON
/// final jsonData = updatedModel.toJson();
/// ```
///
class NoteDataPackageModel extends NoteDataPackage {
  /// Creates a new instance of [NoteDataPackageModel].
  ///
  /// **Parameters:**
  /// - `notes`: A list of [NoteModel] objects that are included in the package.
  /// - `creationDate`: The date and time of package creation.
  /// - `exportedBy`: The name or identifier of the exporter (defaults to an empty string).
  /// - `exportVersion`: The version of the export process or application (defaults to an empty string).
  /// - `description`: An optional description of the notes package (defaults to an empty string).
  const NoteDataPackageModel({
    required super.notes,
    required super.creationDate,
    super.exportedBy = '',
    super.exportVersion = '',
    super.description = '',
  });

  /// Creates a [NoteDataPackageModel] instance from a [NoteDataPackage] entity.
  ///
  /// **Parameters:**
  /// - `data`: The [NoteDataPackage] entity to convert.
  ///
  /// **Returns:**
  /// A new instance of [NoteDataPackageModel].
  factory NoteDataPackageModel.fromEntity(NoteDataPackage data) {
    return NoteDataPackageModel(
      notes: data.notes,
      creationDate: data.creationDate,
      exportedBy: data.exportedBy,
      exportVersion: data.exportVersion,
      description: data.description,
    );
  }

  /// Creates a [NoteDataPackageModel] instance from a JSON map.
  ///
  /// **Parameters:**
  /// - `json`: A JSON map containing the data to convert.
  ///
  /// **Returns:**
  /// A new instance of [NoteDataPackageModel].
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

  /// Creates a copy of the current [NoteDataPackageModel] with optional modifications.
  ///
  /// **Parameters:**
  /// - `notes`: A new list of [NoteModel] objects to replace the existing ones (optional).
  /// - `creationDate`: A new creation date to replace the existing one (optional).
  /// - `exportedBy`: A new exporter name or identifier to replace the existing one (optional).
  /// - `exportVersion`: A new export version to replace the existing one (optional).
  /// - `description`: A new description to replace the existing one (optional).
  ///
  /// **Returns:**
  /// A new instance of [NoteDataPackageModel] with the updated values.
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

  /// Converts the current [NoteDataPackageModel] to a JSON map.
  ///
  /// **Returns:**
  /// A JSON map representing the [NoteDataPackageModel].
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
