import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

void main() {
  group('TextBlock', () {
    test('should create a TextBlock instance with default values', () {
      const textBlock = TextBlock(
        id: 1,
      );

      expect(textBlock.id, 1);
      expect(textBlock.title, "");
      expect(textBlock.hasTitle, true);
      expect(textBlock.type, NoteBlockType.text);
      expect(textBlock.text, "");
      expect(textBlock.hasMaxLineLimit, false);
      expect(textBlock.maxLines, 3);
    });

    test('should create a TextBlock instance with custom values', () {
      const textBlock = TextBlock(
        id: 2,
        title: "Custom Title",
        hasTitle: false,
        text: "Sample text",
        hasMaxLineLimit: true,
        maxLines: 5,
      );
  });
}
