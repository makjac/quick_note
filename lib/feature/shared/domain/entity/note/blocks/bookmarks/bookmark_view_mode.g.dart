// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_view_mode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookmarkViewModeAdapter extends TypeAdapter<BookmarkViewMode> {
  @override
  final int typeId = 9;

  @override
  BookmarkViewMode read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BookmarkViewMode.list;
      case 10:
        return BookmarkViewMode.grid;
      case 20:
        return BookmarkViewMode.icons;
      default:
        return BookmarkViewMode.list;
    }
  }

  @override
  void write(BinaryWriter writer, BookmarkViewMode obj) {
    switch (obj) {
      case BookmarkViewMode.list:
        writer.writeByte(0);
        break;
      case BookmarkViewMode.grid:
        writer.writeByte(10);
        break;
      case BookmarkViewMode.icons:
        writer.writeByte(20);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookmarkViewModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
