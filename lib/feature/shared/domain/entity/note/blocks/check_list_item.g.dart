// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_list_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChecklistItemAdapter extends TypeAdapter<ChecklistItem> {
  @override
  final int typeId = 5;

  @override
  ChecklistItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChecklistItem(
      id: fields[0] as num,
      title: fields[10] == null ? '' : fields[10] as String,
      isChecked: fields[20] == null ? false : fields[20] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ChecklistItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(10)
      ..write(obj.title)
      ..writeByte(20)
      ..write(obj.isChecked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChecklistItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
