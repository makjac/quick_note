part of 'injection_container.dart';

final locator = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  final http.Client client = http.Client();
  locator.registerLazySingleton<http.Client>(() => client);

  await _initPreferences();
  await _initNoteSearch();
  await _initApp();
  await _initNotebook();
  await _initBookmarks();
  await _initAnalyticsService();
  await _initAdMobService();
}

FutureOr<void> _initPreferences() async {
  locator.registerFactory<PreferencesBloc>(
      () => PreferencesBloc(sharedPreferences: locator()));
}

FutureOr<void> _initNoteSearch() async {
  locator.registerFactory<NoteSearchCubit>(() => NoteSearchCubit());
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
    ..registerLazySingleton<DeleteEmptyNotesUsecase>(
        () => DeleteEmptyNotesUsecase(repository: locator()))
    ..registerFactory<AppBloc>(
      () => AppBloc(
        loadCachedNotes: locator(),
        createNote: locator(),
        deleteAllNotes: locator(),
        deleteMultipleNotes: locator(),
        updateMultipleNotes: locator(),
        updateSingleNote: locator(),
        deleteSingleNote: locator(),
        deleteEmptyNotes: locator(),
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
    ..registerFactory<NotebookCommandManager>(
        () => NotebookCommandManagerImpl())
    ..registerFactory(
      () => NotebookBloc(
        commandManager: locator(),
        createNote: locator(),
        updateSingleNote: locator(),
        deleteNote: locator(),
        getNoteByKey: locator(),
      ),
    );
}

FutureOr<void> _initBookmarks() async {
  locator
    ..registerLazySingleton<BookmarksRemoteDatasource>(
        () => BookmarksRemoteDatasourceImpl(client: locator()))
    ..registerLazySingleton<BookmarkRepository>(
        () => BookmarkRepositoryImpl(datasource: locator()))
    ..registerLazySingleton<FetchAllFaviconDataUsecase>(
        () => FetchAllFaviconDataUsecase(repository: locator()))
    ..registerLazySingleton<FetchBestFaviconUrlUsecase>(
        () => FetchBestFaviconUrlUsecase(repository: locator()))
    ..registerLazySingleton<IsValidFaviconUrlUsecase>(
        () => IsValidFaviconUrlUsecase(repository: locator()))
    ..registerFactoryParam<BookmarksBlockCubit, BookmarksBlock?, NotebookBloc>(
      (block, notebookBlocSubscription) => BookmarksBlockCubit(
        block: block,
        notebookBloc: notebookBlocSubscription,
        fetchBestFaviconUrlUsecase: locator(),
      ),
    );
}

FutureOr<void> _initAnalyticsService() async {
  if (PlatformHelper.isMobile()) {
    locator.registerLazySingleton<AnalyticsService>(() => AnalyticsService());
  }
}

FutureOr<void> _initAdMobService() async {
  if (PlatformHelper.isMobile()) {
    locator.registerLazySingleton<AdMobService>(() => AdMobService());
  }
}
