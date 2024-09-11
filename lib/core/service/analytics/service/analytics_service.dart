import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:quick_note/core/service/analytics/enum/note_action.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

class AnalyticsService {
  factory AnalyticsService({FirebaseAnalytics? analytics}) =>
      AnalyticsService._(analytics: analytics);

  AnalyticsService._({FirebaseAnalytics? analytics})
      : _analytics = analytics ?? FirebaseAnalytics.instance;

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

  void logToggleArchiveNoteEvent(bool isArchived) {
    _analytics.logEvent(
      name: 'note_event',
      parameters: {
        'action':
            isArchived ? NoteAction.archived.name : NoteAction.unarchived.name,
      },
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

  void logUnstarNoteEvent() {
    _analytics.logEvent(
      name: 'note_event',
      parameters: {'action': NoteAction.unstared.name},
    );
  }

  void logChangeNoteColorEvent() {
    _analytics.logEvent(
      name: 'note_event',
      parameters: {'action': NoteAction.colorChanged.name},
    );
  }

  void logAddBlockEvent(NoteBlockType blockType) {
    _analytics.logEvent(
      name: 'note_event',
      parameters: {
        'action': NoteAction.addedBlock.name,
        'block_type': blockType.name,
      },
    );
  }

  void logRemoveBlockEvent(NoteBlockType blockType) {
    _analytics.logEvent(
      name: 'note_event',
      parameters: {
        'action': NoteAction.removedBlock.name,
        'block_type': blockType.name,
      },
    );
  }

  void logReorderBlocksEvent() {
    _analytics.logEvent(
      name: 'note_event',
      parameters: {'action': NoteAction.reorderBlocks.name},
    );
  }
}
