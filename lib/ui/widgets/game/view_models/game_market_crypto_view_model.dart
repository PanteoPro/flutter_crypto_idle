import 'package:crypto_idle/domain/entities/price_token.dart';
import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/domain/repositories/price_token_repository.dart';
import 'package:crypto_idle/domain/repositories/token_repository.dart';
import 'package:flutter/cupertino.dart';

class GameMarketCryptoViewModelState {
  GameMarketCryptoViewModelState({required this.token, required this.prices});
  GameMarketCryptoViewModelState.empty({this.token, this.prices = const []});

  final Token? token;
  final List<PriceToken> prices;
}

class GameMarketCryptoViewModel extends ChangeNotifier {
  GameMarketCryptoViewModel({required Token token}) {
    _state = GameMarketCryptoViewModelState.empty(token: token);
    initialRepositories();
  }

  final _tokenRepository = TokenRepository();
  final _priceTokenRepository = PriceTokenRepository();

  var _state = GameMarketCryptoViewModelState.empty();
  GameMarketCryptoViewModelState get state => _state;

  Future<void> initialRepositories() async {
    _tokenRepository.init();
    _priceTokenRepository.init();
    _updateState();
  }

  void _updateState() {
    final token = _tokenRepository.tokens.firstWhere((element) => element.id == _state.token?.id);
    _state = GameMarketCryptoViewModelState(
      token: token,
      prices: _priceTokenRepository.prices,
    );
  }
}
