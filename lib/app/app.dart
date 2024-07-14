import 'package:flutter/material.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';
import 'package:quick_note/injection_container.dart';
import 'package:quick_note/l10n/bloc/i10n_bloc.bloc.dart';
import 'package:quick_note/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/router/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<I10nBloc>(
          create: (context) => locator<I10nBloc>(),
        ),
        BlocProvider<AppBloc>(
          create: (context) => locator<AppBloc>()..add(LoadCachedNotes()),
        )
      ],
      child: const _App(),
    );
  }
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<I10nBloc, I10nState>(
      builder: (context, state) {
        return MaterialApp.router(
          title: 'Quick notes',
          routeInformationParser: AppRouter.router.routeInformationParser,
          routeInformationProvider: AppRouter.router.routeInformationProvider,
          routerDelegate: AppRouter.router.routerDelegate,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: state.currentLanguage.locale,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
