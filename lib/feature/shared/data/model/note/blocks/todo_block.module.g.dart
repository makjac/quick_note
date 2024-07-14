// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_block.module.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoBlockModelAdapter extends TypeAdapter<TodoBlockModel> {
  @override
  final int typeId = 4;

  @override
  TodoBlockModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoBlockModel(
      id: fields[0] as num,
      type: fields[10] as NoteBlockType,
      items: fields[20] == null
          ? []
          : (fields[20] as List).cast<ChecklistItemModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, TodoBlockModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(20)
      ..write(obj.items)
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
      other is TodoBlockModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
