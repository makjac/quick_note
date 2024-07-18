// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_block.module.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TextBlockModelAdapter extends TypeAdapter<TextBlockModel> {
  @override
  final int typeId = 3;

  @override
  TextBlockModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TextBlockModel(
      id: fields[0] as num,
      title: fields[1] == null ? '' : fields[1] as String,
      type: fields[10] as NoteBlockType,
      text: fields[20] == null ? '' : fields[20] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TextBlockModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(20)
      ..write(obj.text)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(10)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextBlockModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
