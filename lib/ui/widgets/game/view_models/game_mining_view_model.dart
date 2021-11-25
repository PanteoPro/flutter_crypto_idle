import 'package:crypto_idle/domain/entities/pc.dart';
import 'package:crypto_idle/domain/entities/price_token.dart';
import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/domain/repositories/pc_repository.dart';
import 'package:crypto_idle/domain/repositories/price_token_repository.dart';
import 'package:crypto_idle/domain/repositories/token_repository.dart';
import 'package:flutter/cupertino.dart';

class GameMiningViewModelState {
  GameMiningViewModelState({
    required this.tokens,
    required this.prices,
    required this.pcs,
  });
  GameMiningViewModelState.empty({
    this.tokens = const [],
    this.prices = const [],
    this.pcs = const [],
  });

  final List<Token> tokens;
  final List<PriceToken> prices;
  final List<PC> pcs;

  bool isOpenModale = false;
  int modaleTokenIndex = 0;

  PriceToken getCurrentPriceByToken(Token token) {
    return prices.where((price) => price.tokenId == token.id).last;
  }
}

class GameMiningViewModel extends ChangeNotifier {
  GameMiningViewModel() {
    initialRepositories();
  }
  final _tokenRepository = TokenRepository();
  final _priceTokenRepository = PriceTokenRepository();
  final _pcRepository = PCRepository();

  var _state = GameMiningViewModelState.empty();
  GameMiningViewModelState get state => _state;

  Future<void> initialRepositories() async {
    await _tokenRepository.init();
    await _priceTokenRepository.init();
    await _pcRepository.init();
    _updateState();
  }

  void _updateState() {
    _state = GameMiningViewModelState(
      tokens: _tokenRepository.tokens,
      prices: _priceTokenRepository.prices,
      pcs: _pcRepository.pcs,
    );
    notifyListeners();
  }

  void onChangeMiningToken(int pcIndex) {
    final pc = _state.pcs[pcIndex];
    final token = _state.tokens[_state.modaleTokenIndex];
    if (pc.miningToken?.id == token.id) {
      pc.miningToken = null;
    } else {
      pc.miningToken = token;
    }
    notifyListeners();
  }

  void onOpenButtonPressed(int index) {
    _state.isOpenModale = true;
    _state.modaleTokenIndex = index;
    notifyListeners();
  }

  void onExitModalAction() {
    _state.isOpenModale = false;
    notifyListeners();
  }
}
