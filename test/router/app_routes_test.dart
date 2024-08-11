import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/router/app_routes.dart';

void main() {
  group('AppRoutes', () {
    test('AppRoutes values should have correct route names', () {
      expect(AppRoutes.unknown.routeName, 'Unknown');
      expect(AppRoutes.homePage.routeName, 'Home_page');
      expect(AppRoutes.notesPage.routeName, 'Notes_Page');
      expect(AppRoutes.remindersPage.routeName, 'Reminders_page');
      expect(AppRoutes.archivePage.routeName, 'Archive_page');
      expect(AppRoutes.trashPage.routeName, 'Trasch_page');
      expect(AppRoutes.settingsPage.routeName, 'Settings_page');
      expect(AppRoutes.helpPage.routeName, 'Help_page');
      expect(AppRoutes.license.routeName, 'license_page');
      expect(AppRoutes.notebook.routeName, 'Notebook_page');
      expect(AppRoutes.notebookReorderBlocks.routeName,
          'Notebook_reorder_blocks_page');
    });
  });
}
