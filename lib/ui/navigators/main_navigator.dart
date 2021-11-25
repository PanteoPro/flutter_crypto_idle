import 'package:crypto_idle/ui/widgets/game/game_crypto_page.dart';
import 'package:crypto_idle/ui/widgets/game/game_market_crypto_page.dart';
import 'package:crypto_idle/ui/widgets/game/game_market_flat_page.dart';
import 'package:crypto_idle/ui/widgets/game/game_market_pc_page.dart';
import 'package:crypto_idle/ui/widgets/game/game_mining_page.dart';
import 'package:crypto_idle/ui/widgets/game/main_game_page.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_crypto_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_market_flat_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_market_pc_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_mining_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

abstract class MainNavigationRouteNames {
  static const main = '/';
  static const gameMarketPC = '/market_pc';
  static const gameMarketFlat = '/market_flat';
  static const gameCrypto = '/crypto';
  static const gameMarketCrypto = '/crypto/market';
  static const gameMining = '/mining';
}

class MainNavigation {
  String initialRoute() => MainNavigationRouteNames.main;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.main: (context) => const MainGamePage(),
    MainNavigationRouteNames.gameMarketPC: (context) => ChangeNotifierProvider<GameMarketPCViewModel>(
          create: (_) => GameMarketPCViewModel(),
          child: const GameMarketPCPage(),
        ),
    MainNavigationRouteNames.gameMarketFlat: (context) => ChangeNotifierProvider(
          create: (_) => GameMarketFlatViewModel(),
          child: const GameMarketFlatPage(),
        ),
    MainNavigationRouteNames.gameCrypto: (context) => ChangeNotifierProvider(
          create: (_) => GameCryptoViewModel(),
          child: const GameCryptoPage(),
        ),
    MainNavigationRouteNames.gameMarketCrypto: (context) => const GameMarketCryptoPage(),
    MainNavigationRouteNames.gameMining: (context) => ChangeNotifierProvider(
          create: (_) => GameMiningViewModel(),
          child: const GameMiningPage(),
        ),
  };
}
