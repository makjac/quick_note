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
      hasTitle: fields[2] == null ? true : fields[2] as bool,
      type: fields[10] as NoteBlockType,
      text: fields[20] == null ? '' : fields[20] as String,
      hasMaxLineLimit: fields[29] == null ? false : fields[29] as bool,
      maxLines: fields[30] == null ? 3 : fields[30] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TextBlockModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(20)
      ..write(obj.text)
      ..writeByte(29)
      ..write(obj.hasMaxLineLimit)
      ..writeByte(30)
      ..write(obj.maxLines)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.hasTitle)
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
