// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.module.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteModelAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 0;

  @override
  NoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteModel(
      id: fields[0] as num,
      created: fields[10] as DateTime,
      modified: fields[20] as DateTime,
      expiryDate: fields[25] as DateTime?,
      title: fields[30] == null ? '' : fields[30] as String,
      content: fields[40] == null ? [] : (fields[40] as List).cast<NoteBlock>(),
      archived: fields[50] == null ? false : fields[50] as bool,
      author: fields[60] == null ? '' : fields[60] as String?,
      isStarred: fields[70] == null ? false : fields[70] as bool,
      color: fields[81] == null ? NoteColors.color1 : fields[81] as NoteColors,
    );
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(10)
      ..write(obj.created)
      ..writeByte(20)
      ..write(obj.modified)
      ..writeByte(25)
      ..write(obj.expiryDate)
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
      ..writeByte(81)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
