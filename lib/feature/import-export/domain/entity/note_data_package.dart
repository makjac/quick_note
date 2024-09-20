import 'package:equatable/equatable.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

/// A class representing a package of notes for export and import.
///
/// This class encapsulates the data related to a collection of notes along with
/// metadata such as creation date, exporter information, and version details.
/// It is used to manage and transport note data between different systems or
/// formats, facilitating both export and import operations.
///
/// **Properties:**
/// - `notes`: A list of [Note] objects that are being exported or imported.
/// - `creationDate`: The date and time when the notes package was created.
/// - `exportedBy`: The name or identifier of the person or system that performed the export.
/// - `exportVersion`: The version of the application used.
/// - `description`: An optional description providing additional context or metadata about the export.
class NoteDataPackage extends Equatable {
  /// Creates a new instance of [NoteDataPackage].
  ///
  /// **Parameters:**
  /// - `notes`: A list of [Note] objects that are included in the package.
  /// - `creationDate`: The date and time of package creation.
  /// - `exportedBy`: The name or identifier of the exporter (defaults to an empty string).
  /// - `exportVersion`: The version of the application used (defaults to an empty string).
  /// - `description`: An optional description of the notes package (defaults to an empty string).
  const NoteDataPackage({
    required this.notes,
    required this.creationDate,
    this.exportedBy = '',
    this.exportVersion = '',
    this.description = '',
  });

  /// A list of [Note] objects included in the package.
  final List<Note> notes;

  /// The date and time when the notes package was created.
  final DateTime creationDate;

  /// The name or identifier of the person or system that performed the export.
  final String exportedBy;

  /// The version of the application used.
  final String exportVersion;

  /// An optional description providing additional context or metadata about the export.
  final String description;

  @override
  List<Object?> get props =>
      [notes, creationDate, exportedBy, exportVersion, description];
}
