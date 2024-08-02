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

  void logDeleteNoteEvent() {
    _analytics.logEvent(
      name: 'note_event',
      parameters: {'action': NoteAction.deleted.name},
    );
  }

  void logArchiveNoteEvent() {
    _analytics.logEvent(
      name: 'note_event',
      parameters: {'action': NoteAction.archived.name},
    );
  }

  void logUnarchiveNoteEvent() {
    _analytics.logEvent(
      name: 'note_event',
      parameters: {'action': NoteAction.unarchived.name},
    );
  }

  void logRestoreNoteEvent() {
    _analytics.logEvent(
      name: 'note_event',
      parameters: {'action': NoteAction.restored.name},
    );
  }

  void logStarNoteEvent() {
    _analytics.logEvent(
      name: 'note_event',
      parameters: {'action': NoteAction.stared.name},
    );
  }
}
