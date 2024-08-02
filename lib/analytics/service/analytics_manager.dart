import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:quick_note/analytics/enum/note_action.dart';

class AnalyticsManager {
  factory AnalyticsManager() => _instance;

  AnalyticsManager._({FirebaseAnalytics? analytics})
      : _analytics = analytics ?? FirebaseAnalytics.instance;

  static final _instance = AnalyticsManager._();

  final FirebaseAnalytics _analytics;

  void logScreenView(String screenName) {
    _analytics.logScreenView(screenName: screenName);
  }

  void logCreateNoteEvent() {
    _analytics.logEvent(
      name: 'note_event',
      parameters: {'action': NoteAction.created.name},
    );
  }
}
