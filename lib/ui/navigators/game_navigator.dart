import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/ui/widgets/game/view/main/main_game_page.dart';
import 'package:crypto_idle/ui/widgets/game/view/market_crypto/market_crypto_navigator_controller.dart';
import 'package:crypto_idle/ui/widgets/game/view/market_crypto/market_crypto_page.dart';
import 'package:crypto_idle/ui/widgets/game/view/market_flat/market_flat_page.dart';
import 'package:crypto_idle/ui/widgets/game/view/market_pc/market_pc_page.dart';
import 'package:crypto_idle/ui/widgets/game/view/old/game_crypto_page.dart';
import 'package:crypto_idle/ui/widgets/game/view/statistics/game_statistics_page.dart';
import 'package:crypto_idle/ui/widgets/game/view/wallet_tokens/wallet_tokens_page.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_crypto_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_market_crypto_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_market_flat_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_market_pc_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_mining_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/global/game_statistics_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/main_game/clicker_game_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/main_game/day_stream_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/main_game/main_game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class GameNavigationRouteNames {
  static const main = '/';
  static const marketPC = '/market_pc';
  static const marketFlat = '/market_flat';
  static const wallet = '/crypto';
  static const marketCrypto = '/crypto/market';
  static const statistics = '/statistics';
}

class GameNavigation {
  static GameMarketCryptoViewModel? gmcvm;

  static String get initialRoute => GameNavigationRouteNames.main;

  static Route<Object> onGenerateRoute(RouteSettings settings) {
    gmcvm?.dispose();
    gmcvm = null;
    switch (settings.name) {
      case GameNavigationRouteNames.marketCrypto:
        final arguments = settings.arguments;
        final token = arguments is Token ? arguments : Token.empty();
        return MaterialPageRoute(
          builder: (context) => MarketCryptoNavigatorController(token: token),
        );
      case GameNavigationRouteNames.main:
        return MaterialPageRoute(
          builder: (ctx) => MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => MainGameViewModel(),
              ),
              ChangeNotifierProvider(
                create: (_) => DayStreamViewModel(),
              ),
              ChangeNotifierProvider(
                create: (_) => ClickerGameViewModel(),
              ),
            ],
            child: const MainGamePage(),
          ),
        );
      case GameNavigationRouteNames.marketPC:
        return MaterialPageRoute(
          builder: (ctx) => ChangeNotifierProvider<GameMarketPCViewModel>(
            create: (_) => GameMarketPCViewModel(),
            child: const MarketPCPage(),
          ),
        );
      case GameNavigationRouteNames.marketFlat:
        return MaterialPageRoute(
          builder: (ctx) => ChangeNotifierProvider(
            create: (_) => GameMarketFlatViewModel(),
            child: const MarketFlatPage(),
          ),
        );
      case GameNavigationRouteNames.wallet:
        return MaterialPageRoute(
          builder: (ctx) => ChangeNotifierProvider(
            create: (_) => GameCryptoViewModel(),
            child: const WalletTokensPage(),
          ),
        );
      case GameNavigationRouteNames.statistics:
        return MaterialPageRoute(
          builder: (ctx) => const GameStatisticsPage(),
        );
      default:
        return MaterialPageRoute(builder: (_) => const Text('Game Navigation Error!'));
    }
  }
}
