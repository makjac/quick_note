// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_colors.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteColorsAdapter extends TypeAdapter<NoteColors> {
  @override
  final int typeId = 6;

  @override
  NoteColors read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NoteColors.color1;
      case 10:
        return NoteColors.color2;
      case 20:
        return NoteColors.color3;
      case 30:
        return NoteColors.color4;
      case 40:
        return NoteColors.color5;
      case 50:
        return NoteColors.color6;
      case 60:
        return NoteColors.color7;
      case 70:
        return NoteColors.color8;
      case 80:
        return NoteColors.color9;
      case 90:
        return NoteColors.color10;
      case 100:
        return NoteColors.color11;
      case 110:
        return NoteColors.color12;
      default:
        return NoteColors.color1;
    }
  }

  @override
  void write(BinaryWriter writer, NoteColors obj) {
    switch (obj) {
      case NoteColors.color1:
        writer.writeByte(0);
        break;
      case NoteColors.color2:
        writer.writeByte(10);
        break;
      case NoteColors.color3:
        writer.writeByte(20);
        break;
      case NoteColors.color4:
        writer.writeByte(30);
        break;
      case NoteColors.color5:
        writer.writeByte(40);
        break;
      case NoteColors.color6:
        writer.writeByte(50);
        break;
      case NoteColors.color7:
        writer.writeByte(60);
        break;
      case NoteColors.color8:
        writer.writeByte(70);
        break;
      case NoteColors.color9:
        writer.writeByte(80);
        break;
      case NoteColors.color10:
        writer.writeByte(90);
        break;
      case NoteColors.color11:
        writer.writeByte(100);
        break;
      case NoteColors.color12:
        writer.writeByte(110);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteColorsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
