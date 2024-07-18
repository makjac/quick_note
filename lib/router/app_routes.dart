enum AppRoutes {
  homePage('Home page', '/'),
  notebook('notebook', '/notebook/:id');

  final String routeName;
  final String path;

  const AppRoutes(this.routeName, this.path);
}
