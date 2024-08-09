// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_item.module.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookmarkItemModelAdapter extends TypeAdapter<BookmarkItemModel> {
  @override
  final int typeId = 8;

  @override
  BookmarkItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookmarkItemModel(
      id: fields[0] as num,
      title: fields[10] == null ? '' : fields[10] as String,
      url: fields[20] == null ? '' : fields[20] as String,
      faviconUrl: fields[25] == null ? '' : fields[25] as String,
      description: fields[30] == null ? '' : fields[30] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BookmarkItemModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(10)
      ..write(obj.title)
      ..writeByte(20)
      ..write(obj.url)
      ..writeByte(25)
      ..write(obj.faviconUrl)
      ..writeByte(30)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookmarkItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
