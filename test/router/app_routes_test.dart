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

    test('AppRoutes values should have correct paths', () {
      expect(AppRoutes.unknown.path, '/');
      expect(AppRoutes.homePage.path, '/');
      expect(AppRoutes.notesPage.path, 'notes');
      expect(AppRoutes.remindersPage.path, 'reminders');
      expect(AppRoutes.archivePage.path, 'archive');
      expect(AppRoutes.trashPage.path, 'trash');
      expect(AppRoutes.settingsPage.path, 'settings');
      expect(AppRoutes.helpPage.path, 'help');
      expect(AppRoutes.license.path, 'license');
      expect(AppRoutes.notebook.path, '/notebook/:id');
      expect(AppRoutes.notebookReorderBlocks.path, 'reorder');
    });

    test('AppRoutes values should match their respective enum names', () {
      expect(AppRoutes.unknown.name, 'unknown');
      expect(AppRoutes.homePage.name, 'homePage');
      expect(AppRoutes.notesPage.name, 'notesPage');
      expect(AppRoutes.remindersPage.name, 'remindersPage');
      expect(AppRoutes.archivePage.name, 'archivePage');
      expect(AppRoutes.trashPage.name, 'trashPage');
      expect(AppRoutes.settingsPage.name, 'settingsPage');
      expect(AppRoutes.helpPage.name, 'helpPage');
      expect(AppRoutes.license.name, 'license');
      expect(AppRoutes.notebook.name, 'notebook');
      expect(AppRoutes.notebookReorderBlocks.name, 'notebookReorderBlocks');
    });
  });
}
