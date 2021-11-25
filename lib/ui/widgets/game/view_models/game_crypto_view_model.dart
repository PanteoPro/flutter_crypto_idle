import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/domain/repositories/price_token_repository.dart';
import 'package:crypto_idle/domain/repositories/token_repository.dart';
import 'package:crypto_idle/ui/navigators/main_navigator.dart';
import 'package:flutter/cupertino.dart';

class GameCryptoViewModelState {
  GameCryptoViewModelState({required this.tokens, required this.currentPrices});
  GameCryptoViewModelState.empty({this.tokens = const [], this.currentPrices = const {}});

  final List<Token> tokens;
  final Map<int, double> currentPrices;

  double getPriceByToken(Token token) {
    return currentPrices[token.id]!;
  }

  double getBalance() {
    double balance = 0;
    for (Token token in tokens) {
      balance += getPriceByToken(token) * token.count;
    }
    return balance;
  }
}

class GameCryptoViewModel extends ChangeNotifier {
  GameCryptoViewModel() {
    initialRepositories();
  }
  final _tokenRepository = TokenRepository();
  final _priceTokenRepository = PriceTokenRepository();

  var _state = GameCryptoViewModelState.empty();
  GameCryptoViewModelState get state => _state;

  Future<void> initialRepositories() async {
    await _tokenRepository.init();
    await _priceTokenRepository.init();
    _updateState();
  }

  void _updateState() {
    final currentPrices = <int, double>{};
    final currentTokens = _tokenRepository.tokens;
    for (var token in currentTokens) {
      currentPrices[token.id] = _priceTokenRepository.getLatestPriceByTokenId(token.id).cost;
    }
    _state = GameCryptoViewModelState(
      tokens: currentTokens,
      currentPrices: currentPrices,
    );
    notifyListeners();
  }

  void onTokenPressed(BuildContext context, Token token) {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.gameMarketCrypto, arguments: token);
  }
}
