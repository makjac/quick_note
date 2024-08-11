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

      expect(textBlock.id, 2);
      expect(textBlock.title, "Custom Title");
      expect(textBlock.hasTitle, false);
      expect(textBlock.type, NoteBlockType.text);
      expect(textBlock.text, "Sample text");
      expect(textBlock.hasMaxLineLimit, true);
      expect(textBlock.maxLines, 5);
    });

    test('should copy TextBlock with updated values using copyWith', () {
      const textBlock = TextBlock(
        id: 3,
        title: "Original Title",
        text: "Original text",
        hasMaxLineLimit: true,
        maxLines: 4,
      );

      final copiedBlock = textBlock.copyWith(
        title: "Updated Title",
        text: "Updated text",
        maxLines: 6,
      );

      expect(copiedBlock.id, 3); // id remains the same
      expect(copiedBlock.title, "Updated Title");
      expect(copiedBlock.text, "Updated text");
      expect(copiedBlock.hasMaxLineLimit, true); // unchanged
      expect(copiedBlock.maxLines, 6); // updated
    });

    test('should compare two TextBlock instances with same values as equal',
        () {
      const textBlock1 = TextBlock(
        id: 4,
        title: "Same Title",
        text: "Same text",
      );

      const textBlock2 = TextBlock(
        id: 4,
        title: "Same Title",
        text: "Same text",
      );

      expect(textBlock1, textBlock2);
    });
  });
}
