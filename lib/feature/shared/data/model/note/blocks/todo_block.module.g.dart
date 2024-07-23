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
      title: fields[1] == null ? '' : fields[1] as String,
      hasTitle: fields[2] == null ? true : fields[2] as bool,
      type: fields[10] as NoteBlockType,
      items: fields[20] == null
          ? []
          : (fields[20] as List).cast<ChecklistItemModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, TodoBlockModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(20)
      ..write(obj.items)
      ..writeByte(30)
      ..write(obj.showCompleteTasks)
      ..writeByte(40)
      ..write(obj.showProgressBar)
      ..writeByte(50)
      ..write(obj.maxVisibleTasks)
      ..writeByte(60)
      ..write(obj.dedline)
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
      other is TodoBlockModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
