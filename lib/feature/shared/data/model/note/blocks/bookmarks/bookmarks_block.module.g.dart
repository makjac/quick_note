// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarks_block.module.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookmarksBlockModelAdapter extends TypeAdapter<BookmarksBlockModel> {
  @override
  final int typeId = 7;

  @override
  BookmarksBlockModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookmarksBlockModel(
      id: fields[0] as num,
      title: fields[1] == null ? '' : fields[1] as String,
      hasTitle: fields[2] == null ? true : fields[2] as bool,
      type: fields[10] as NoteBlockType,
      items: fields[20] == null
          ? []
          : (fields[20] as List).cast<BookmarkItemModel>(),
      visibleFavicons: fields[30] == null ? true : fields[30] as bool,
      maxVisibleBookmakrs: fields[40] as int?,
      viewMode: fields[50] == null
          ? BookmarkViewMode.list
          : fields[50] as BookmarkViewMode,
    );
  }

  @override
  void write(BinaryWriter writer, BookmarksBlockModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(20)
      ..write(obj.items)
      ..writeByte(30)
      ..write(obj.visibleFavicons)
      ..writeByte(40)
      ..write(obj.maxVisibleBookmakrs)
      ..writeByte(50)
      ..write(obj.viewMode)
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
      other is BookmarksBlockModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
