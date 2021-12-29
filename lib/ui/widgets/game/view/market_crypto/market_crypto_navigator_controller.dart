import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/ui/widgets/game/view/market_crypto/market_crypto_page.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_market_crypto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// This controller need for controlling dispose GameMarketCryptoViewModel, because usage Provider.value
class MarketCryptoNavigatorController extends StatefulWidget {
  const MarketCryptoNavigatorController({Key? key, required this.token}) : super(key: key);
  final Token token;

  @override
  _MarketCryptoNavigatorControllerState createState() => _MarketCryptoNavigatorControllerState();
}

class _MarketCryptoNavigatorControllerState extends State<MarketCryptoNavigatorController> {
  late GameMarketCryptoViewModel vm;

  @override
  void initState() {
    vm = GameMarketCryptoViewModel(token: widget.token);
    super.initState();
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: vm,
      child: const MarketCryptoPage(),
    );
  }
}
