import 'package:hive/hive.dart';
import 'package:quick_note/core/error/exception/cache_exception.dart';
import 'package:quick_note/feature/shared/data/model/note/note.module.dart';
import 'package:quick_note/hive/hive_keys.dart';

abstract class AppLocalDataSource {
  Future<List<NoteModel>> getNotes();
  Future<void> createNote(NoteModel note);
  Future<void> updateNote(num id, NoteModel note);
  Future<void> updateMultipleNotes(Map<dynamic, NoteModel> updates);
  Future<void> deleteNote(num id);
  Future<void> deleteMultipleNotes(List<num> ids);
  Future<int> deleteAllNotes();
}

class AppLocalDataSourceImpl implements AppLocalDataSource {
  final HiveInterface hive;
  late Box<NoteModel>? _noteBox;

  AppLocalDataSourceImpl({required this.hive});

  @override
  Future<List<NoteModel>> getNotes() async {
    try {
      final box = await hive.openBox<NoteModel>(HiveBoxes.note.name);
      List<NoteModel> note = box.values.toList();

      return note;
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<void> createNote(NoteModel note) async {
    try {
      final box = await hive.openBox<NoteModel>(HiveBoxes.note.name);
      await box.put(note.id.toInt(), note);
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<void> updateNote(num id, NoteModel note) async {
    try {
      final box = await hive.openBox<NoteModel>(HiveBoxes.note.name);
      await box.put(note.id, note);
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<void> updateMultipleNotes(Map<dynamic, NoteModel> updates) async {
    try {
      final box = await hive.openBox<NoteModel>(HiveBoxes.note.name);
      await box.putAll(updates);
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteNote(num id) async {
    try {
      final box = await hive.openBox<NoteModel>(HiveBoxes.note.name);
      box.delete(id);
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteMultipleNotes(List<num> ids) async {
    try {
      final box = await hive.openBox<NoteModel>(HiveBoxes.note.name);
      box.deleteAll(ids);
    } catch (_) {
      throw CacheException();
    }
  }

  void dispose() async {
    await _noteBox?.close();
  }

  @override
  Future<int> deleteAllNotes() async {
    try {
      final box = await hive.openBox<NoteModel>(HiveBoxes.note.name);
      final status = await box.clear();

      return status;
    } catch (_) {
      throw CacheException();
    }
  }
}
