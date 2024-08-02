enum AppRoutes {
  unknown('Unknown', '/'),
  homePage('Home_page', '/'),
  notesPage('Notes_Page', 'notes'),
  remindersPage('Reminders_page', 'reminders'),
  archivePage('Archive_page', 'archive'),
  trashPage('Trasch_page', 'trash'),
  settingsPage('Settings_page', 'settings'),
  helpPage('Help_page', 'help'),
  license('license_page', 'license'),
  notebook('Notebook_page', '/notebook/:id'),
  notebookReorderBlocks('Notebook_reorder_blocks_page', 'reorder');

  final String routeName;
  final String path;

  const AppRoutes(this.routeName, this.path);
}
