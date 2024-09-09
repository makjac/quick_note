import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/l10n/l10n.dart';

void main() {
  testWidgets('AppLocalizationsX extension returns AppLocalizations instance',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (BuildContext context) {
            final l10n = context.l10n;

            expect(l10n, isNotNull);
            return Container();
          },
        ),
      ),
    );
  });
}
