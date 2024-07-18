part of 'injection_container.dart';

final locator = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  await _initI10n();
  await _initPreferences();
  await _initApp();
  await _initNotebook();

  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

FutureOr<void> _initI10n() async {
  locator
      .registerFactory<I10nBloc>(() => I10nBloc(sharedPreferences: locator()));
}

FutureOr<void> _initPreferences() async {
  locator.registerFactory<PreferencesBloc>(
      () => PreferencesBloc(sharedPreferences: locator()));
}

FutureOr<void> _initApp() async {
  locator
    ..registerLazySingleton<AppLocalDataSource>(
        () => AppLocalDataSourceImpl(hive: Hive))
    ..registerLazySingleton<AppRepository>(
        () => AppRepositoryImpl(localDataSource: locator()))
    ..registerLazySingleton<CreateNoteUsecase>(
        () => CreateNoteUsecase(repository: locator()))
    ..registerLazySingleton<LoadCachedNotesUsecase>(
        () => LoadCachedNotesUsecase(repository: locator()))
    ..registerLazySingleton<DeleteAllNotesUsecase>(
        () => DeleteAllNotesUsecase(repository: locator()))
    ..registerLazySingleton<DeleteMiltipleNotesUsecase>(
        () => DeleteMiltipleNotesUsecase(repository: locator()))
    ..registerLazySingleton<UpdateMultipleNotesUsecase>(
        () => UpdateMultipleNotesUsecase(repository: locator()))
    ..registerLazySingleton<UpdateSingleNoteUsecase>(
        () => UpdateSingleNoteUsecase(repository: locator()))
    ..registerLazySingleton<DeleteSingleNoteUsecase>(
        () => DeleteSingleNoteUsecase(repository: locator()))
    ..registerFactory<AppBloc>(
      () => AppBloc(
        loadCachedNotes: locator(),
        createNote: locator(),
        deleteAllNotes: locator(),
        deleteMultipleNotes: locator(),
        updateMultipleNotes: locator(),
        updateSingleNote: locator(),
        deleteSingleNote: locator(),
      ),
    );
}

FutureOr<void> _initNotebook() async {
  locator
    ..registerLazySingleton<NotebookLocalDatasource>(
        () => NotebookLocalDatasourceImpl(hive: Hive))
    ..registerLazySingleton<NotebookRepository>(
        () => NotebookRepositoryImpl(datasource: locator()))
    ..registerLazySingleton<GetNoteByKeyUsecase>(
        () => GetNoteByKeyUsecase(repository: locator()))
    ..registerFactory(
      () => NotebookBloc(
        createNote: locator(),
        updateSingleNote: locator(),
        deleteNote: locator(),
        getNoteByKey: locator(),
      ),
    );
}
