import 'dart:async';
import 'dart:math';

import 'package:crypto_idle/domain/entities/flat.dart';
import 'package:crypto_idle/domain/entities/game.dart';
import 'package:crypto_idle/domain/entities/news.dart';
import 'package:crypto_idle/domain/entities/pc.dart';
import 'package:crypto_idle/domain/entities/price_token.dart';
import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/domain/repositories/flat_repository.dart';
import 'package:crypto_idle/domain/repositories/game_repository.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';
import 'package:crypto_idle/domain/repositories/news_repository.dart';
import 'package:crypto_idle/domain/repositories/pc_repository.dart';
import 'package:crypto_idle/domain/repositories/price_token_repository.dart';
import 'package:crypto_idle/domain/repositories/statistics_repository.dart';
import 'package:crypto_idle/domain/repositories/token_repository.dart';
import 'package:flutter/cupertino.dart';

class GameViewModelState {
  GameViewModelState({
    required this.game,
    required this.pcs,
    required this.flats,
    required this.currentPrices,
    required this.tokens,
  });
  const GameViewModelState.empty({
    this.game,
    this.pcs = const [],
    this.flats = const [],
    this.currentPrices = const {},
    this.tokens = const [],
  });
  final Game? game;
  final List<PC> pcs;
  final List<Flat> flats;
  final Map<int, double> currentPrices;
  final List<Token> tokens;

  int get currentCountPC => pcs.length;
  int get maxCountPC => flats.firstWhere((element) => element.isActive).countPC;

  double getPriceByToken(Token token) {
    return currentPrices[token.id]!;
  }

  double get balance {
    double balance = 0;
    for (final Token token in tokens) {
      balance += getPriceByToken(token) * token.count;
    }
    return double.parse(balance.toStringAsFixed(2));
  }
}

class GameViewModel extends ChangeNotifier {
  GameViewModel() {
    _initialRepository();
  }

  @override
  void dispose() {
    _gameStreamSub?.cancel();
    _pcStreamSub?.cancel();
    _flatStreamSub?.cancel();
    _tokenStreamSub?.cancel();
    _priceTokenStreamSub?.cancel();
    _statisticsStreamSub?.cancel();
    super.dispose();
  }

  // Repositories
  final _gameRepository = GameRepository();
  final _pcRepository = PCRepository();
  final _flatRepository = FlatRepository();
  final _tokenRepository = TokenRepository();
  final _priceTokenRepository = PriceTokenRepository();
  final _statisticsRepository = StatisticsRepository();
  final _newsRepository = NewsRepository();

  StreamSubscription<dynamic>? _gameStreamSub;
  StreamSubscription<dynamic>? _pcStreamSub;
  StreamSubscription<dynamic>? _flatStreamSub;
  StreamSubscription<dynamic>? _tokenStreamSub;
  StreamSubscription<dynamic>? _priceTokenStreamSub;
  StreamSubscription<dynamic>? _statisticsStreamSub;

  // Data
  var _state = GameViewModelState.empty();
  GameViewModelState get state => _state;

  /// Initial Repository
  Future<void> _initialRepository() async {
    await _gameRepository.init();
    await _pcRepository.init();
    await _flatRepository.init();
    await _tokenRepository.init();
    await _priceTokenRepository.init();
    await _statisticsRepository.init();
    await _newsRepository.init();
    _subscriteStreams();
    updateState();
  }

  /// Subscribes to Repositories streams
  void _subscriteStreams() {
    _gameStreamSub = GameRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _gameRepository));
    _pcStreamSub = PCRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _pcRepository));
    _flatStreamSub = FlatRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _flatRepository));
    _tokenStreamSub =
        TokenRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _tokenRepository));
    _priceTokenStreamSub =
        PriceTokenRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _priceTokenRepository));
    _statisticsStreamSub =
        StatisticsRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _statisticsRepository));
  }

  Future<void> _updateRepoByChangeEvent(dynamic data, MyRepository repository) async {
    await repository.updateData();
    updateState();
  }

  void updateState() {
    final currentPrices = <int, double>{};
    final currentTokens = _tokenRepository.tokens;
    for (final token in currentTokens) {
      currentPrices[token.id] = _priceTokenRepository.getLatestPriceByTokenId(token.id).cost;
    }
    _state = GameViewModelState(
      game: _gameRepository.game.copyWith(),
      flats: _flatRepository.flats,
      pcs: _pcRepository.pcs,
      currentPrices: currentPrices,
      tokens: currentTokens,
    );
    notifyListeners();
  }

  void BABLO() {
    _gameRepository.changeData(money: _state.game!.money + 100);
  }
}
