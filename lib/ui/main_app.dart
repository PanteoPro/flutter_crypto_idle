import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:crypto_idle/Theme/themes.dart';
import 'package:crypto_idle/domain/repositories/music_manager.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/ui/navigators/main_navigator.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/global/game_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/global/message_stream_view_model.dart';
import 'package:crypto_idle/ui/widgets/main_app_view_model.dart';
import 'package:crypto_idle/ui/widgets/music_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: kLightTheme,
      initial: AdaptiveThemeMode.dark,
      builder: (ThemeData light, ThemeData dark) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => MainAppViewModel(),
          ),
          ChangeNotifierProvider(
            create: (_) => MusicViewModel(),
            lazy: false,
          ),
        ],
        child: MyMaterialApp(light, dark),
      ),
    );
  }
}

class MyMaterialApp extends StatefulWidget {
  MyMaterialApp(
    this.light,
    this.dark, [
    Key? key,
  ]) : super(key: key);

  final ThemeData light;
  final ThemeData dark;

  @override
  State<MyMaterialApp> createState() => _MyMaterialAppState();
}

class _MyMaterialAppState extends State<MyMaterialApp> with WidgetsBindingObserver {
  final mainNavigation = MainNavigation();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      MusicManager.pause();
    } else if (state == AppLifecycleState.resumed) {
      MusicManager.resume();
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.select((MainAppViewModel vm) => vm.locale);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: locale,
      theme: widget.light,
      darkTheme: widget.dark,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      initialRoute: mainNavigation.initialRoute(),
      routes: mainNavigation.routes,
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}
