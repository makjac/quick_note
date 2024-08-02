import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsManager {
  factory AnalyticsManager() => _instance;

  AnalyticsManager._({FirebaseAnalytics? analytics})
      : _analytics = analytics ?? FirebaseAnalytics.instance;

  static final _instance = AnalyticsManager._();

  final FirebaseAnalytics _analytics;
}
