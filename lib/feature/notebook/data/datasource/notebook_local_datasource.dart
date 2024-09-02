import 'package:hive/hive.dart';
import 'package:quick_note/core/error/exception/cache_exception.dart';
import 'package:quick_note/core/error/exception/cache_value_exception.dart';
import 'package:quick_note/feature/shared/data/model/note/note.module.dart';
import 'package:quick_note/hive/hive_keys.dart';

abstract class NotebookLocalDatasource {
  Future<NoteModel> getNoteByKey(num key);
}

class NotebookLocalDatasourceImpl extends NotebookLocalDatasource {
  final HiveInterface hive;

  NotebookLocalDatasourceImpl({required this.hive});

  @override
  Future<NoteModel> getNoteByKey(num key) async {
    try {
      try {
        final box = await hive.openBox<NoteModel>(HiveBoxes.note.name);
        final NoteModel? note = box.get(key);

        if (note == null) throw CacheValueException();

        return note;
      } catch (_) {
        throw CacheException();
      }
    } catch (_) {
      throw CacheException();
    }
  }
}
