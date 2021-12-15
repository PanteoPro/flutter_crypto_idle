import 'dart:async';

import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';
import 'package:crypto_idle/domain/repositories/price_token_repository.dart';
import 'package:crypto_idle/domain/repositories/token_repository.dart';
import 'package:crypto_idle/ui/navigators/main_navigator.dart';
import 'package:flutter/cupertino.dart';

class GameCryptoViewModelState {
  GameCryptoViewModelState({required this.tokens, required this.currentPrices}) {
    _filterTokens();
  }
  GameCryptoViewModelState.empty({this.tokens = const [], this.currentPrices = const {}});

  final List<Token> tokens;
  final Map<int, double> currentPrices;
  List<Token> filtered = [];

  double getPriceByToken(Token token) {
    return currentPrices[token.id]!;
  }

  double getBalance() {
    double balance = 0;
    for (final token in tokens) {
      balance += getPriceByToken(token) * token.count;
    }
    return balance;
  }

  void _filterTokens() {
    final scamTokens = <Token>[];
    final toSort = <Token, double>{};
    for (final token in tokens) {
      if (token.isScam) {
        scamTokens.add(token);
      } else {
        toSort[token] = getPriceByToken(token) * token.count;
      }
    }
    var sortedKeys = toSort.keys.toList(growable: false)..sort((k1, k2) => toSort[k1]!.compareTo(toSort[k2]!));
    sortedKeys = sortedKeys.reversed.toList();
    // final filt = sortedKeys.map((key) => toSort[key]).toList();
    filtered = [];
    for (final filtToken in sortedKeys) {
      // if (filtToken != null) {
      filtered.add(filtToken);
      // }
    }
    filtered.addAll(scamTokens);
  }
}

class GameCryptoViewModel extends ChangeNotifier {
  GameCryptoViewModel() {
    _initialRepositories();
    _subscriteStreams();
  }

  @override
  void dispose() {
    _tokenStreamSub?.cancel();
    _priceStreamSub?.cancel();
    super.dispose();
  }

  // Repositories
  final _tokenRepository = TokenRepository();
  final _priceTokenRepository = PriceTokenRepository();
  StreamSubscription<dynamic>? _tokenStreamSub;
  StreamSubscription<dynamic>? _priceStreamSub;

  // Data
  var _state = GameCryptoViewModelState.empty();
  GameCryptoViewModelState get state => _state;

  /// Initial repositories
  Future<void> _initialRepositories() async {
    await _tokenRepository.init();
    await _priceTokenRepository.init();

    _updateState();
  }

  /// Subscribe to Streams from repositories
  void _subscriteStreams() {
    _tokenStreamSub = TokenRepository.stream?.listen(
      (dynamic data) => _updateRepoByChangeEvent(data, _tokenRepository),
    );
    _priceStreamSub = PriceTokenRepository.stream?.listen(
      (dynamic data) => _updateRepoByChangeEvent(data, _priceTokenRepository),
    );
  }

  Future<void> _updateRepoByChangeEvent(dynamic data, MyRepository repository) async {
    repository.updateData();
    _updateState();
  }

  void _updateState() {
    final currentPrices = <int, double>{};
    final currentTokens = _tokenRepository.tokens;
    for (final token in currentTokens) {
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
