import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/feature/notebook/presentation/widget/notebook_leyout/notebook_header/Notebook_desktop_icons_menu/notebook_desktop_icons_menu.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/l10n/l10n.dart';

class MockNotebookBloc extends MockBloc<NotebookEvent, NotebookState>
    implements NotebookBloc {}

class FakeNotebookState extends Fake implements NotebookState {}

void main() {
  late MockNotebookBloc mockNotebookBloc;

  setUpAll(() {
    registerFallbackValue(FakeNotebookState());
  });

  setUp(() {
    mockNotebookBloc = MockNotebookBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: BlocProvider<NotebookBloc>(
          create: (_) => mockNotebookBloc,
          child: const NotebookDesktopIconsMenu(),
        ),
      ),
    );
  }

  testWidgets('renders NotebookDesktopIconsMenu', (tester) async {
    when(() => mockNotebookBloc.state).thenReturn(NotebookState(
        note: Note(id: 1, created: DateTime.now(), modified: DateTime.now())));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(NotebookDesktopIconsMenu), findsOneWidget);
  });

  testWidgets('tapping undo button adds NotebookUndo event', (tester) async {
    when(() => mockNotebookBloc.state)
        .thenReturn(const NotebookState(note: null));

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.byIcon(Icons.undo));
    verify(() => mockNotebookBloc.add(NotebookUndo())).called(1);
  });

  testWidgets('tapping redo button adds NotebookRedo event', (tester) async {
    when(() => mockNotebookBloc.state)
        .thenReturn(const NotebookState(note: null));

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.byIcon(Icons.redo));
    verify(() => mockNotebookBloc.add(NotebookRedo())).called(1);
  });

  testWidgets('tapping star button adds NotebookToggleStar event',
      (tester) async {
    when(() => mockNotebookBloc.state)
        .thenReturn(const NotebookState(note: null));

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.byIcon(Icons.star_border));
    verify(() => mockNotebookBloc.add(NotebookToggleStar())).called(1);
  });

  testWidgets('tapping archive button adds NotebookToggleArchive event',
      (tester) async {
    when(() => mockNotebookBloc.state)
        .thenReturn(const NotebookState(note: null));

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.byIcon(Icons.archive_outlined));
    verify(() => mockNotebookBloc.add(NotebookToggleArchive())).called(1);
  });
}
