import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/bookmark_block_command/bookmark_block_title_visibility_command.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';

void main() {
  group('BookmarkBlockTitleVisibilityCommand', () {
    late BookmarksBlock block;
    late BookmarkBlockTitleVisibilityCommand command;

    setUp(() {
      block = const BookmarksBlock(id: 1, hasTitle: false);
      command =
          BookmarkBlockTitleVisibilityCommand(block: block, isVisible: true);
    });

    test('should return correct ownerId', () {
      expect(command.ownerId, block.id);
    });

    test('should return correct title', () {
      expect(command.getTitle(), "Bookmark Block: Change title visibility");
    });

    test('should return correct type', () {
      expect(command.type, NotebookCommandType.bookmark);
    });

    test('should execute command and change title visibility', () {
      final updatedBlock = command.execute();
      expect(updatedBlock.hasTitle, true);
    });

    test('should undo command and revert title visibility', () {
      command.execute();
      final revertedBlock = command.undo();
      expect(revertedBlock.hasTitle, false);
    });
  });
}
