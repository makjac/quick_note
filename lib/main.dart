import 'package:flutter/material.dart';
import 'package:quick_note/app/app.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(const App());
}
