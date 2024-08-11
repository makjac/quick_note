import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/utils/platform_helper.dart';

class _BaseWidget extends StatefulWidget {
  const _BaseWidget();

  @override
  State<_BaseWidget> createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<_BaseWidget> {
  String _text = 'unknown';

  void _setText() {
    setState(() {
      if (PlatformHelper.isMobile()) {
        _text = "mobile";
      } else {
        _text = "not mobile";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(_text),
          ElevatedButton(
            onPressed: _setText,
            child: const Text('Check platform'),
          ),
        ],
      ),
    );
  }
}

void main() {
  group('PlatformHelper', () {
    testWidgets('isMobile returns false on the Windows platform',
        (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.windows;

      await tester.pumpWidget(
        const MaterialApp(
          home: _BaseWidget(),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.text('Check platform'));
      await tester.pumpAndSettle();

      expect(find.text("not mobile"), findsOneWidget);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('isMobile returns true for Android platform',
        (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;

      await tester.pumpWidget(
        const MaterialApp(
          home: _BaseWidget(),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.text('Check platform'));
      await tester.pumpAndSettle();

      expect(find.text("mobile"), findsOneWidget);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('isMobile returns true for iOS platform',
        (WidgetTester tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      await tester.pumpWidget(
        const MaterialApp(
          home: _BaseWidget(),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.text('Check platform'));
      await tester.pumpAndSettle();

      expect(find.text("mobile"), findsOneWidget);

      debugDefaultTargetPlatformOverride = null;
    });
  });
}
