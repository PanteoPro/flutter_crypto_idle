import 'package:crypto_idle/ui/widgets/game/game_crypto_page.dart';
import 'package:crypto_idle/ui/widgets/game/game_market_flat_page.dart';
import 'package:crypto_idle/ui/widgets/game/game_market_pc_page.dart';
import 'package:crypto_idle/ui/widgets/game/main_game_page.dart';
import 'package:flutter/cupertino.dart';

abstract class MainNavigationRouteNames {
  static const main = '/';
  static const gameMarketPC = '/market_pc';
  static const gameMarketFlat = '/market_flat';
  static const gameCrypto = '/crypto';
}

class MainNavigation {
  String initialRoute() => MainNavigationRouteNames.main;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.main: (context) => const MainGamePage(),
    MainNavigationRouteNames.gameMarketPC: (context) => const GameMarketPCPage(),
    MainNavigationRouteNames.gameMarketFlat: (context) => const GameMarketFlatPage(),
    MainNavigationRouteNames.gameCrypto: (context) => const GameCryptoPage(),
  };
}
