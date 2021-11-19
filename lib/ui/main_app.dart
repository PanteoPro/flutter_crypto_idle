import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:crypto_idle/Theme/themes.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/ui/widgets/game/main_game_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: kLightTheme,
      initial: AdaptiveThemeMode.dark,
      builder: (ThemeData light, ThemeData dark) => MaterialApp(
        theme: light,
        darkTheme: dark,
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: const MainGamePage(),
      ),
    );
  }
}
