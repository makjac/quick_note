import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:quick_note/core/service/analytics/enum/note_action.dart';
import 'package:quick_note/core/service/analytics/service/analytics_service.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

import 'analytics_service_test.mocks.dart';

@GenerateMocks([FirebaseAnalytics])
void main() {
  group('AnalyticsService', () {
    late MockFirebaseAnalytics mockFirebaseAnalytics;
    late AnalyticsService analyticsService;

    setUp(() {
      mockFirebaseAnalytics = MockFirebaseAnalytics();
      analyticsService = AnalyticsService(analytics: mockFirebaseAnalytics);
    });

    test(
        'logScreenView calls FirebaseAnalytics.logScreenView with correct parameters',
        () {
      analyticsService.logScreenView('home_screen');

      verify(mockFirebaseAnalytics.logScreenView(screenName: 'home_screen'))
          .called(1);
    });

    test('logCreateNoteEvent logs the correct event', () {
      analyticsService.logCreateNoteEvent();

      verify(mockFirebaseAnalytics.logEvent(
        name: 'note_event',
        parameters: {'action': NoteAction.created.name},
      )).called(1);
    });

    test('logDeleteNoteEvent logs the correct event', () {
      analyticsService.logDeleteNoteEvent();

      verify(mockFirebaseAnalytics.logEvent(
        name: 'note_event',
        parameters: {'action': NoteAction.deleted.name},
      )).called(1);
    });

    test('logArchiveNoteEvent logs the correct event', () {
      analyticsService.logArchiveNoteEvent();

      verify(mockFirebaseAnalytics.logEvent(
        name: 'note_event',
        parameters: {'action': NoteAction.archived.name},
      )).called(1);
    });

    test('logUnarchiveNoteEvent logs the correct event', () {
      analyticsService.logUnarchiveNoteEvent();

      verify(mockFirebaseAnalytics.logEvent(
        name: 'note_event',
        parameters: {'action': NoteAction.unarchived.name},
      )).called(1);
    });

    test('logRestoreNoteEvent logs the correct event', () {
      analyticsService.logRestoreNoteEvent();

      verify(mockFirebaseAnalytics.logEvent(
        name: 'note_event',
        parameters: {'action': NoteAction.restored.name},
      )).called(1);
    });

    test('logStarNoteEvent logs the correct event', () {
      analyticsService.logStarNoteEvent();

      verify(mockFirebaseAnalytics.logEvent(
        name: 'note_event',
        parameters: {'action': NoteAction.stared.name},
      )).called(1);
    });

    test('logUnstarNoteEvent logs the correct event', () {
      analyticsService.logUnstarNoteEvent();

      verify(mockFirebaseAnalytics.logEvent(
        name: 'note_event',
        parameters: {'action': NoteAction.unstared.name},
      )).called(1);
    });

    test('logChangeNoteColorEvent logs the correct event', () {
      analyticsService.logChangeNoteColorEvent();

      verify(mockFirebaseAnalytics.logEvent(
        name: 'note_event',
        parameters: {'action': NoteAction.colorChanged.name},
      )).called(1);
    });

    test('logAddBlockEvent logs the correct event with block type', () {
      analyticsService.logAddBlockEvent(NoteBlockType.text);

      verify(mockFirebaseAnalytics.logEvent(
        name: 'note_event',
        parameters: {
          'action': NoteAction.addedBlock.name,
          'block_type': NoteBlockType.text.name,
        },
      )).called(1);
    });

    test('logRemoveBlockEvent logs the correct event with block type', () {
      analyticsService.logRemoveBlockEvent(NoteBlockType.text);

      verify(mockFirebaseAnalytics.logEvent(
        name: 'note_event',
        parameters: {
          'action': NoteAction.removedBlock.name,
          'block_type': NoteBlockType.text.name,
        },
      )).called(1);
    });
  });
}
