import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/shared/presentation/widget/debounce_text_field.dart';

void main() {
  group('DebounceTextField Tests', () {
    testWidgets('should build the widget correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DebounceTextField(
              onDebounceChange: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(DebounceTextField), findsOneWidget);
    });

    testWidgets('should debounce text input', (WidgetTester tester) async {
      bool debounceCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DebounceTextField(
              onDebounceChange: (text) {
                debounceCalled = true;
              },
              debounceDuration: const Duration(milliseconds: 500),
            ),
          ),
        ),
      );

      final textField = find.byType(TextField);
      await tester.enterText(textField, 'test input');
      expect(debounceCalled, isFalse);

      await tester.pump(const Duration(milliseconds: 500));
      expect(debounceCalled, isTrue);
    });

    testWidgets('should call onDebounceChange callback after debounce period',
        (WidgetTester tester) async {
      String debouncedText = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DebounceTextField(
              onDebounceChange: (text) {
                debouncedText = text;
              },
              debounceDuration: const Duration(milliseconds: 300),
            ),
          ),
        ),
      );

      final textField = find.byType(TextField);
      await tester.enterText(textField, 'debounced input');
      await tester.pump(const Duration(milliseconds: 300));

      expect(debouncedText, 'debounced input');
    });
  });
}
