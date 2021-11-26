import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/ui/widgets/game/game_crypto_page.dart';
import 'package:crypto_idle/ui/widgets/game/game_market_crypto_page.dart';
import 'package:crypto_idle/ui/widgets/game/game_market_flat_page.dart';
import 'package:crypto_idle/ui/widgets/game/game_market_pc_page.dart';
import 'package:crypto_idle/ui/widgets/game/game_mining_page.dart';
import 'package:crypto_idle/ui/widgets/game/main_game_page.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_crypto_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_market_crypto_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_market_flat_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_market_pc_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_mining_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_view_model.dart';
import 'package:flutter/material.dart';
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
    MainNavigationRouteNames.gameCrypto: (context) {
      final gvm = context.read<GameViewModel>();
      return ChangeNotifierProvider(
        create: (_) => GameCryptoViewModel(gvm: gvm),
        child: const GameCryptoPage(),
      );
    },
    MainNavigationRouteNames.gameMining: (context) => ChangeNotifierProvider(
          create: (_) => GameMiningViewModel(),
          child: const GameMiningPage(),
        ),
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
