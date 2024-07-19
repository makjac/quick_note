enum AppRoutes {
  homePage('Home_page', '/'),
  notesPage('Notes_Page', 'notes'),
  remindersPage('Reminders_page', 'reminders'),
  archivePage('Archive_page', 'archive'),
  trashPage('Trasch_page', 'trash'),
  settingsPage('Settings_page', 'settings'),
  helpPage('Help_page', 'help'),
  notebook('Notebook_page', '/notebook/:id');

  final String routeName;
  final String path;

  const AppRoutes(this.routeName, this.path);
}
