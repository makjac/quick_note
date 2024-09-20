import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/shared/data/model/note/blocks/bookmarks/bookmarks_block.module.dart';
import 'package:quick_note/feature/shared/data/model/note/blocks/text/text_block.module.dart';
import 'package:quick_note/feature/shared/data/model/note/blocks/todo/todo_block.module.dart';
import 'package:quick_note/feature/shared/data/model/note/note_block.module.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

void main() {
  group('NoteBlockModel', () {
    test('fromEntity creates correct TextBlockModel', () {
      const textBlock = TextBlock(id: 1, text: 'Sample text');
      final model = NoteBlockModel.fromEntity(textBlock);

      expect(model, isA<TextBlockModel>());
      expect(model.id, textBlock.id);
      expect((model as TextBlockModel).text, textBlock.text);
    });

    test('fromEntity creates correct TodoBlockModel', () {
      const todoBlock = TodoBlock(id: 2, items: []);
      final model = NoteBlockModel.fromEntity(todoBlock);

      expect(model, isA<TodoBlockModel>());
      expect(model.id, todoBlock.id);
      expect((model as TodoBlockModel).items, todoBlock.items);
    });

    test('fromEntity creates correct BookmarksBlockModel', () {
      const bookmarksBlock = BookmarksBlock(id: 3, items: []);
      final model = NoteBlockModel.fromEntity(bookmarksBlock);

      expect(model, isA<BookmarksBlockModel>());
      expect(model.id, bookmarksBlock.id);
      expect((model as BookmarksBlockModel).items, bookmarksBlock.items);
    });

    test('fromJson creates correct TextBlockModel', () {
      final json = {
        'id': 1,
        'type': NoteBlockType.text.index,
        'text': 'Sample text',
      };
      final model = NoteBlockModel.fromJson(json);

      expect(model, isA<TextBlockModel>());
      expect(model.id, json['id']);
      expect((model as TextBlockModel).text, json['text']);
    });

    test('fromJson creates correct TodoBlockModel', () {
      final json = {
        'id': 2,
        'type': NoteBlockType.todo.index,
        'items': [],
      };
      final model = NoteBlockModel.fromJson(json);

      expect(model, isA<TodoBlockModel>());
      expect(model.id, json['id']);
      expect((model as TodoBlockModel).items, json['items']);
    });

    test('toJson returns correct map for TextBlockModel', () {
      const model = TextBlockModel(id: 1, text: 'Sample text');
      final json = model.toJson();

      expect(json['id'], model.id);
      expect(json['type'], NoteBlockType.text.index);
      expect(json['text'], model.text);
    });

    test('toJson returns correct map for TodoBlockModel', () {
      const model = TodoBlockModel(id: 2, items: []);
      final json = model.toJson();

      expect(json['id'], model.id);
      expect(json['type'], NoteBlockType.todo.index);
      expect(json['items'], model.items);
    });

    test('toJson returns correct map for BookmarksBlockModel', () {
      const model = BookmarksBlockModel(id: 3, items: []);
      final json = model.toJson();

      expect(json['id'], model.id);
      expect(json['type'], NoteBlockType.bookmarks.index);
      expect(json['items'], model.items);
    });
  });
}
