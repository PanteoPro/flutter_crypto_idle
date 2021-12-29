import 'dart:async';

import 'package:flutter/material.dart';

import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/domain/repositories/message_manager.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';
import 'package:crypto_idle/domain/repositories/price_token_repository.dart';
import 'package:crypto_idle/domain/repositories/token_repository.dart';
import 'package:crypto_idle/ui/navigators/game_navigator.dart';
import 'package:crypto_idle/ui/navigators/main_navigator.dart';

class GameCryptoViewModelStateTokenWithPercent {
  GameCryptoViewModelStateTokenWithPercent({
    required this.token,
    required this.percent,
    required this.color,
  });
  final Token token;
  final double percent;
  final Color color;

  @override
  String toString() => 'TokenWithPercent(percent: $percent, color: $color)';
}

class GameCryptoViewModelState {
  GameCryptoViewModelState({
    required this.tokens,
    required this.currentPrices,
    required this.isHideNullBalance,
  }) {
    _filterTokens();
  }
  GameCryptoViewModelState.empty({
    this.tokens = const [],
    this.currentPrices = const {},
    this.isHideNullBalance = false,
  });

  final List<Token> tokens;
  final Map<int, double> currentPrices;
  List<Token> _filtered = [];
  bool isHideNullBalance;

  int get filteredLength => _filtered.length;

  Token getFilteredToken(int index) {
    if (_filtered.length > index) {
      return _filtered[index];
    }
    return Token.empty();
  }

  List<GameCryptoViewModelStateTokenWithPercent> get getTokensWithPercent {
    const colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.grey,
    ];
    final list = <GameCryptoViewModelStateTokenWithPercent>[];
    final sumTokens = getBalance();
    var colorId = 0;
    for (final token in _filtered) {
      final cost = getPriceByToken(token) * token.count;
      if (cost != 0) {
        list.add(
          GameCryptoViewModelStateTokenWithPercent(
            token: token,
            percent: cost / sumTokens,
            color: colors[colorId > 4 ? 0 : colorId],
          ),
        );
        colorId++;
      }
    }
    list.sort((a, b) => b.percent.compareTo(a.percent));
    if (list.length > 4) {
      final other = list.sublist(4);
      var sumOther = 0.0;
      for (final token in other) {
        sumOther += getPriceByToken(token.token) * token.token.count;
      }
      list.removeRange(4, list.length);
      list.add(GameCryptoViewModelStateTokenWithPercent(
          token: Token.empty(symbol: 'Other'), percent: sumOther / sumTokens, color: colors.last));
    } else if (list.isEmpty) {
      list.add(
        GameCryptoViewModelStateTokenWithPercent(
          token: Token.empty(symbol: 'Other'),
          percent: 1,
          color: colors.last,
        ),
      );
    } else {
      list.add(
        GameCryptoViewModelStateTokenWithPercent(
          token: Token.empty(symbol: 'Other'),
          percent: 0,
          color: colors.last,
        ),
      );
    }

    return list;
  }

  double getCostByToken(Token token) {
    final price = getPriceByToken(token);
    return token.count * price;
  }

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
    _filtered = [];
    for (final filtToken in sortedKeys) {
      // if (filtToken != null) {
      _filtered.add(filtToken);
      // }
    }
    _filtered.addAll(scamTokens);
    if (isHideNullBalance) {
      _filtered = _filtered.where((element) => element.count != 0).toList();
    }
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
    _messageStreamSub?.cancel();
    super.dispose();
  }

  // Repositories
  final _tokenRepository = TokenRepository();
  final _priceTokenRepository = PriceTokenRepository();
  StreamSubscription<dynamic>? _tokenStreamSub;
  StreamSubscription<dynamic>? _priceStreamSub;

  StreamSubscription<dynamic>? _messageStreamSub;

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
    _messageStreamSub = MessageManager.stream?.listen((event) {
      notifyListeners();
    });
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
      isHideNullBalance: _state.isHideNullBalance,
    );
    notifyListeners();
  }

  void onTokenPressed(BuildContext context, Token token) {
    Navigator.of(context).pushNamed(GameNavigationRouteNames.marketCrypto, arguments: token);
  }

  void onHideNullBalanceButtonPressed() {
    _state.isHideNullBalance = !_state.isHideNullBalance;
    _updateState();
  }
}
