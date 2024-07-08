part of 'injection_container.dart';

final locator = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  await initI10n();

  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

FutureOr<void> initI10n() {
  locator
      .registerFactory<I10nBloc>(() => I10nBloc(sharedPreferences: locator()));
}
