import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/shared/data/model/note/blocks/text/text_block.module.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

void main() {
  group('TextBlockModel', () {
    test('should create a TextBlockModel instance with correct properties', () {
      const textBlockModel = TextBlockModel(
        id: 1,
        title: 'Sample Title',
        hasTitle: true,
        text: 'Sample text',
        hasMaxLineLimit: true,
        maxLines: 5,
      );

      expect(textBlockModel.id, 1);
      expect(textBlockModel.title, 'Sample Title');
      expect(textBlockModel.hasTitle, true);
      expect(textBlockModel.text, 'Sample text');
      expect(textBlockModel.hasMaxLineLimit, true);
      expect(textBlockModel.maxLines, 5);
      expect(textBlockModel.type, NoteBlockType.text);
    });

    test('should convert TextBlock to TextBlockModel using fromEntity', () {
      const textBlock = TextBlock(
        id: 1,
        title: 'Sample Title',
        hasTitle: true,
        text: 'Sample text',
        hasMaxLineLimit: true,
        maxLines: 5,
      );

      final textBlockModel = TextBlockModel.fromEntity(textBlock);

      expect(textBlockModel.id, textBlock.id);
      expect(textBlockModel.title, textBlock.title);
      expect(textBlockModel.hasTitle, textBlock.hasTitle);
      expect(textBlockModel.text, textBlock.text);
      expect(textBlockModel.hasMaxLineLimit, textBlock.hasMaxLineLimit);
      expect(textBlockModel.maxLines, textBlock.maxLines);
      expect(textBlockModel.type, textBlock.type);
    });

    test('should convert JSON to TextBlockModel using fromJson', () {
      final json = {
        'id': 1,
        'title': 'Sample Title',
        'hasTitle': true,
        'type': 0,
        'text': 'Sample text',
        'hasMaxLineLimit': true,
        'maxLines': 5,
      };

      final textBlockModel = TextBlockModel.fromJson(json);

      expect(textBlockModel.id, 1);
      expect(textBlockModel.title, 'Sample Title');
      expect(textBlockModel.hasTitle, true);
      expect(textBlockModel.text, 'Sample text');
      expect(textBlockModel.hasMaxLineLimit, true);
      expect(textBlockModel.maxLines, 5);
      expect(textBlockModel.type, NoteBlockType.text);
    });

    test('should convert TextBlockModel to JSON using toJson', () {
      const textBlockModel = TextBlockModel(
        id: 1,
        title: 'Sample Title',
        hasTitle: true,
        text: 'Sample text',
        hasMaxLineLimit: true,
        maxLines: 5,
      );

      final json = textBlockModel.toJson();

      expect(json['id'], 1);
      expect(json['title'], 'Sample Title');
      expect(json['hasTitle'], true);
      expect(json['type'], NoteBlockType.text.index);
      expect(json['text'], 'Sample text');
      expect(json['hasMaxLineLimit'], true);
      expect(json['maxLines'], 5);
    });

    test(
        'should compare two TextBlockModel instances with the same values as equal',
        () {
      const textBlockModel1 = TextBlockModel(
        id: 1,
        title: 'Sample Title',
        hasTitle: true,
        text: 'Sample text',
        hasMaxLineLimit: true,
        maxLines: 5,
      );

      const textBlockModel2 = TextBlockModel(
        id: 1,
        title: 'Sample Title',
        hasTitle: true,
        text: 'Sample text',
        hasMaxLineLimit: true,
        maxLines: 5,
      );

      expect(textBlockModel1, textBlockModel2);
    });

    test(
        'should compare two TextBlockModel instances with different values as not equal',
        () {
      const textBlockModel1 = TextBlockModel(
        id: 1,
        title: 'Sample Title',
        hasTitle: true,
        text: 'Sample text',
        hasMaxLineLimit: true,
        maxLines: 5,
      );

      const textBlockModel2 = TextBlockModel(
        id: 2,
        title: 'Different Title',
        hasTitle: false,
        text: 'Different text',
        hasMaxLineLimit: false,
        maxLines: 3,
      );

      expect(textBlockModel1, isNot(textBlockModel2));
    });
  });
}
