// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteAdapter extends TypeAdapter<Note> {
  @override
  final int typeId = 0;

  @override
  Note read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Note(
      id: fields[0] as num,
      created: fields[10] as DateTime,
      modified: fields[20] as DateTime,
      title: fields[30] as String,
      content:
          fields[40] == null ? [] : (fields[40] as List?)?.cast<NoteBlock>(),
      archived: fields[50] == null ? false : fields[50] as bool,
      author: fields[60] == null ? '' : fields[60] as String?,
      isStarred: fields[70] == null ? false : fields[70] as bool,
      colorHex: fields[80] == null ? 'ffa600' : fields[80] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Note obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(10)
      ..write(obj.created)
      ..writeByte(20)
      ..write(obj.modified)
      ..writeByte(30)
      ..write(obj.title)
      ..writeByte(40)
      ..write(obj.content)
      ..writeByte(50)
      ..write(obj.archived)
      ..writeByte(60)
      ..write(obj.author)
      ..writeByte(70)
      ..write(obj.isStarred)
      ..writeByte(80)
      ..write(obj.colorHex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
