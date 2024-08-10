// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_block_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteBlockTypeAdapter extends TypeAdapter<NoteBlockType> {
  @override
  final int typeId = 2;

  @override
  NoteBlockType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NoteBlockType.text;
      case 10:
        return NoteBlockType.todo;
      case 20:
        return NoteBlockType.bookmarks;
      default:
        return NoteBlockType.text;
    }
  }

  @override
  void write(BinaryWriter writer, NoteBlockType obj) {
    switch (obj) {
      case NoteBlockType.text:
        writer.writeByte(0);
        break;
      case NoteBlockType.todo:
        writer.writeByte(10);
        break;
      case NoteBlockType.bookmarks:
        writer.writeByte(20);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteBlockTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
