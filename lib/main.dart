import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quick_note/app/app.dart';
import 'package:quick_note/firebase_options.dart';
import 'package:quick_note/hive/hive.dart' as hive;
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await hive.init();
  await di.init();

  runApp(const App());
}
