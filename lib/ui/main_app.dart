import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:crypto_idle/Theme/themes.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/ui/navigators/main_navigator.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_view_model.dart';
import 'package:crypto_idle/ui/widgets/main_app_view_model.dart';
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
          ChangeNotifierProvider(create: (_) => MainAppViewModel()),
          ChangeNotifierProvider(create: (_) => GameViewModel()),
        ],
        child: MyMaterialApp(light, dark),
      ),
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  MyMaterialApp(
    this.light,
    this.dark, [
    Key? key,
  ]) : super(key: key);

  final mainNavigation = MainNavigation();
  final ThemeData light;
  final ThemeData dark;

  @override
  Widget build(BuildContext context) {
    final locale = context.select((MainAppViewModel vm) => vm.locale);
    return MaterialApp(
      locale: locale,
      theme: light,
      darkTheme: dark,
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
