part of 'hive.dart';

Future<void> init() async {
  await Hive.initFlutter();
  await _registerNoteAdapters();
}

FutureOr<void> _registerNoteAdapters() async {
  Hive.registerAdapter(NoteModelAdapter());
  Hive.registerAdapter(NoteBlockTypeAdapter());
  Hive.registerAdapter(TextBlockModelAdapter());
  Hive.registerAdapter(ChecklistItemModelAdapter());
  Hive.registerAdapter(TodoBlockModelAdapter());
  Hive.registerAdapter(NoteColorsAdapter());
}
