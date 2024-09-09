import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/bookmark_block_command/bookmark_block_change_block_view_mode_command.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_view_mode.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';

void main() {
  group('BookmarkBlockChangeBlockViewModeCommand', () {
    late BookmarksBlock block;
    late BookmarkViewMode newViewMode;
    late BookmarkBlockChangeBlockViewModeCommand command;

    setUp(() {
      block = const BookmarksBlock(id: 1, viewMode: BookmarkViewMode.list);
      newViewMode = BookmarkViewMode.grid;
      command = BookmarkBlockChangeBlockViewModeCommand(
        block: block,
        newViewMode: newViewMode,
      );
    });

    test('should return correct ownerId', () {
      expect(command.ownerId, block.id);
    });

    test('should return correct title', () {
      expect(command.getTitle(), "Bookmark Block: Change block view mode");
    });

    test('should return correct type', () {
      expect(command.type, NotebookCommandType.bookmark);
    });

    test('should execute command and change view mode', () {
      final updatedBlock = command.execute();
      expect(updatedBlock.viewMode, newViewMode);
    });

    test('should undo command and revert to original block', () {
      command.execute();
      final revertedBlock = command.undo();
      expect(revertedBlock.viewMode, block.viewMode);
    });
  });
}
