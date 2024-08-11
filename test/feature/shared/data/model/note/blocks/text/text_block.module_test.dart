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
  });
}
