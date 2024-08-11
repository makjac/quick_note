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
  });
}
