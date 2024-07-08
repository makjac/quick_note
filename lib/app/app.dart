import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quick_note/injection_container.dart';
import 'package:quick_note/l10n/app_language.dart';
import 'package:quick_note/l10n/bloc/i10n_bloc.bloc.dart';
import 'package:quick_note/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<I10nBloc>(
          create: (context) => locator<I10nBloc>(),
        ),
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
        return MaterialApp(
          title: 'Quick notes',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('pl'),
          ],
          locale: state.currentLanguage.locale,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(context.l10n.helloWorld),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
              onPressed: () => BlocProvider.of<I10nBloc>(context)
                  .add(const ChangeLanguage(language: AppLanguage.english)),
              child: const Text("English")),
          ElevatedButton(
              onPressed: () => BlocProvider.of<I10nBloc>(context)
                  .add(const ChangeLanguage(language: AppLanguage.polish)),
              child: const Text("Polish")),
        ],
      ),
    );
  }
}
