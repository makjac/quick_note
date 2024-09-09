import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';

class MockNotebookCommand extends Mock implements NotebookCommand<String> {}

void main() {
  late MockNotebookCommand mockCommand;

  setUp(() {
    mockCommand = MockNotebookCommand();
  });

  group('NotebookCommand Tests with mocktail', () {
    test('should return the correct title', () {
      when(() => mockCommand.getTitle()).thenReturn('Test Command');

      final title = mockCommand.getTitle();

      expect(title, 'Test Command');
    });

    test('should return the correct type', () {
      when(() => mockCommand.type).thenReturn(NotebookCommandType.text);

      final type = mockCommand.type;

      expect(type, NotebookCommandType.text);
    });

    test('should execute and return expected result', () {
      when(() => mockCommand.execute()).thenReturn('Executed');

      final result = mockCommand.execute();

      expect(result, 'Executed');
    });

    test('should undo and return expected result', () {
      when(() => mockCommand.undo()).thenReturn('Undone');

      final result = mockCommand.undo();

      expect(result, 'Undone');
    });

    test('should handle optional ownerId', () {
      when(() => mockCommand.ownerId).thenReturn(1);

      final ownerId = mockCommand.ownerId;

      expect(ownerId, 1);
    });
  });
}
