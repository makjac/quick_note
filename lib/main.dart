import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:quick_note/app/app.dart';
import 'package:quick_note/core/utils/platform_helper.dart';
import 'package:quick_note/firebase_options.dart';
import 'package:quick_note/hive/hive.dart' as hive;
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await _initAnalytics();
  await _initCrashlytics();

  await hive.init();
  await di.init();

  runApp(const App());
}

FutureOr<void> _initAnalytics() async {
  if (PlatformHelper.isMobile()) {
    await FirebaseAnalytics.instance.logAppOpen();
  }
}

FutureOr<void> _initCrashlytics() async {
  if (PlatformHelper.isMobile()) {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
}
