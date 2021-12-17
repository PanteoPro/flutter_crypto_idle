import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/ui/widgets/game/view/game_crypto_page.dart';
import 'package:crypto_idle/ui/widgets/game/view/game_market_crypto_page.dart';
import 'package:crypto_idle/ui/widgets/game/view/game_market_flat_page.dart';
import 'package:crypto_idle/ui/widgets/game/view/game_market_pc_page.dart';
import 'package:crypto_idle/ui/widgets/game/view/game_mining_page.dart';
import 'package:crypto_idle/ui/widgets/game/view/main_game_page.dart';
import 'package:crypto_idle/ui/widgets/game/view/main_game/new_main_game_page.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/day_stream_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_crypto_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_market_crypto_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_market_flat_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_market_pc_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_mining_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/main_game_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/message_stream_view_model.dart';
import 'package:crypto_idle/ui/widgets/menu/view/menu_about_page.dart';
import 'package:crypto_idle/ui/widgets/menu/view/menu_page.dart';
import 'package:crypto_idle/ui/widgets/menu/view/menu_settings_page.dart';
import 'package:crypto_idle/ui/widgets/menu/view/test_page.dart';
import 'package:crypto_idle/ui/widgets/menu/view_models/menu_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class MainNavigationRouteNames {
  static const gameMain = 'game';
  static const gameMarketPC = 'game/market_pc';
  static const gameMarketFlat = 'game/market_flat';
  static const gameCrypto = 'game/crypto';
  static const gameMarketCrypto = 'game/crypto/market';
  static const gameMining = 'game/mining';
  static const menu = 'menu';
  static const menuSettings = 'menu/settings';
  static const menuAbout = 'menu/about';
  static const test = 'menu/test';
  static const newDesign = 'menu/newDesign';
}

class MainNavigation {
  String initialRoute() => MainNavigationRouteNames.menu;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.gameMain: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => MainGameViewModel(),
            ),
            ChangeNotifierProvider(
              create: (_) => DayStreamViewModel(),
            ),
          ],
          child: const MainGamePage(),
        ),
    MainNavigationRouteNames.gameMarketPC: (context) => ChangeNotifierProvider<GameMarketPCViewModel>(
          create: (_) => GameMarketPCViewModel(),
          child: const GameMarketPCPage(),
        ),
    MainNavigationRouteNames.gameMarketFlat: (context) => ChangeNotifierProvider(
          create: (_) => GameMarketFlatViewModel(),
          child: const GameMarketFlatPage(),
        ),
    MainNavigationRouteNames.gameCrypto: (context) {
      return ChangeNotifierProvider(
        create: (_) => GameCryptoViewModel(),
        child: const GameCryptoPage(),
      );
    },
    MainNavigationRouteNames.gameMining: (context) => ChangeNotifierProvider(
          create: (_) => GameMiningViewModel(),
          child: const GameMiningPage(),
        ),
    MainNavigationRouteNames.menu: (context) =>
        ChangeNotifierProvider(create: (ctx) => MenuViewModel(ctx), child: const MenuWidget()),
    MainNavigationRouteNames.menuSettings: (context) => const MenuSettingsPage(),
    MainNavigationRouteNames.menuAbout: (context) => const MenuAboutWidget(),
    MainNavigationRouteNames.test: (context) => const TestWidget(),
    MainNavigationRouteNames.newDesign: (context) => const MainGamePage(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.gameMarketCrypto:
        final token = settings.arguments is Token ? settings.arguments as Token : Token.empty();
        final viewModel = GameMarketCryptoViewModel(token: token);
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider.value(
            value: viewModel,
            child: const GameMarketCryptoPage(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const Text('Navigation Error!'));
    }
  }
}
