// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_block.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TextBlockAdapter extends TypeAdapter<TextBlock> {
  @override
  final int typeId = 3;

  @override
  TextBlock read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TextBlock(
      id: fields[0] as num,
      type: fields[10] as NoteBlockType,
      text: fields[20] == null ? '' : fields[20] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TextBlock obj) {
    writer
      ..writeByte(3)
      ..writeByte(20)
      ..write(obj.text)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(10)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextBlockAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
