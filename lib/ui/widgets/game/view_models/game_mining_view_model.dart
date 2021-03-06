import 'dart:async';

import 'package:crypto_tycoon/domain/repositories/game_repository.dart';
import 'package:flutter/material.dart';

import 'package:crypto_tycoon/domain/entities/pc.dart';
import 'package:crypto_tycoon/domain/entities/price_token.dart';
import 'package:crypto_tycoon/domain/entities/token.dart';
import 'package:crypto_tycoon/domain/repositories/my_repository.dart';
import 'package:crypto_tycoon/domain/repositories/pc_repository.dart';
import 'package:crypto_tycoon/domain/repositories/price_token_repository.dart';
import 'package:crypto_tycoon/domain/repositories/token_repository.dart';

class GameMiningViewModelState {
  GameMiningViewModelState({
    required this.tokens,
    required this.prices,
    required this.pcs,
    required this.date,
    bool? isOpenModale,
    int? modaleTokenIndex,
    List<PC>? filtered,
  }) {
    if (isOpenModale != null) {
      this.isOpenModale = isOpenModale;
    }
    if (modaleTokenIndex != null) {
      this.modaleTokenIndex = modaleTokenIndex;
    }
    if (filtered != null) {
      this.filtered = filtered;
    }
  }
  GameMiningViewModelState.empty({
    this.tokens = const [],
    this.prices = const [],
    this.pcs = const [],
  }) {
    date = DateTime(0);
  }

  final List<Token> tokens;
  final List<PriceToken> prices;
  final List<PC> pcs;
  late DateTime date;
  List<PC>? filtered;

  bool isOpenModale = false;
  int modaleTokenIndex = 0;

  List<PriceToken> _pricesByTokenId(int tokenId) => prices.where((element) => element.tokenId == tokenId).toList();
  PriceToken _getLatestPriceByTokenId(int tokenId) => _pricesByTokenId(tokenId).last;

  List<Token> get availableTokens {
    final availableTokens = <Token>[];
    for (final token in tokens) {
      final price = _getLatestPriceByTokenId(token.id);
      if (price.cost > 0) {
        availableTokens.add(token);
      }
    }
    return availableTokens;
  }

  PriceToken getCurrentPriceByToken(Token token) {
    return prices.where((price) => price.tokenId == token.id).last;
  }

  PriceToken getDataAfterPriceByToken({required Token token, required DateTime fromDate, required int daysAgo}) {
    try {
      return prices.firstWhere(
          (price) => price.date.isAfter(fromDate.add(Duration(days: -daysAgo))) && price.tokenId == token.id);
    } catch (e) {
      return prices.firstWhere((price) => price.tokenId == token.id);
    }
  }

  void sortedPCFirstEmpty() {
    filtered = pcs.where((element) => element.miningToken == null).toList();
    filtered?.addAll(pcs.where((element) => element.miningToken != null).toList());
  }

  GameMiningViewModelState copyWith({
    List<Token>? tokens,
    List<PriceToken>? prices,
    List<PC>? pcs,
    bool? isOpenModale,
    int? modaleTokenIndex,
    List<PC>? filtered,
    DateTime? date,
  }) {
    return GameMiningViewModelState(
      tokens: tokens ?? this.tokens,
      prices: prices ?? this.prices,
      pcs: pcs ?? this.pcs,
      isOpenModale: isOpenModale ?? this.isOpenModale,
      modaleTokenIndex: modaleTokenIndex ?? this.modaleTokenIndex,
      filtered: filtered ?? this.filtered,
      date: date ?? this.date,
    );
  }
}

class GameMiningViewModel extends ChangeNotifier {
  GameMiningViewModel() {
    initialRepositories();
  }

  @override
  void dispose() {
    _tokenStreamSub?.cancel();
    _priceStreamSub?.cancel();
    _pcStreamSub?.cancel();
    _gameStreamSub?.cancel();
    super.dispose();
  }

  // Repositories
  final _tokenRepository = TokenRepository();
  final _priceTokenRepository = PriceTokenRepository();
  final _pcRepository = PCRepository();
  final _gameRepository = GameRepository();
  StreamSubscription<dynamic>? _tokenStreamSub;
  StreamSubscription<dynamic>? _priceStreamSub;
  StreamSubscription<dynamic>? _pcStreamSub;
  StreamSubscription<dynamic>? _gameStreamSub;

  // Data
  var _state = GameMiningViewModelState.empty();
  GameMiningViewModelState get state => _state;

  /// Initial Repository
  Future<void> initialRepositories() async {
    await _tokenRepository.init();
    await _priceTokenRepository.init();
    await _pcRepository.init();
    await _gameRepository.init();

    _subscriteStreams();
    _updateState();
  }

  /// Subscribes to Repositories streams
  void _subscriteStreams() {
    _tokenStreamSub = TokenRepository.stream?.listen(
      (dynamic data) => _updateRepoByChangeEvent(data, _tokenRepository),
    );
    _priceStreamSub = PriceTokenRepository.stream?.listen(
      (dynamic data) => _updateRepoByChangeEvent(data, _priceTokenRepository),
    );
    _pcStreamSub = PCRepository.stream?.listen(
      (dynamic data) => _updateRepoByChangeEvent(data, _pcRepository),
    );
    _gameStreamSub = GameRepository.stream?.listen(
      (dynamic data) => _updateRepoByChangeEvent(data, _gameRepository),
    );
  }

  Future<void> _updateRepoByChangeEvent(dynamic data, MyRepository repository) async {
    repository.updateData();
    _updateState();
  }

  void _updateState() {
    _state = _state.copyWith(
      tokens: _tokenRepository.tokens,
      prices: _priceTokenRepository.prices,
      pcs: _pcRepository.pcs,
      date: _gameRepository.game.date,
    );
    notifyListeners();
  }

  Future<void> onChangeMiningToken(int pcIndex) async {
    final pc = _state.filtered![pcIndex];
    final token = _state.availableTokens[_state.modaleTokenIndex];
    if (pc.miningToken?.id == token.id) {
      await _pcRepository.changeMiningToken(pc);
    } else {
      await _pcRepository.changeMiningToken(pc, token);
    }
    notifyListeners();
  }

  void onOpenButtonPressed(int index) {
    _state.isOpenModale = true;
    _state.modaleTokenIndex = index;
    _state.sortedPCFirstEmpty();
    notifyListeners();
  }

  void onExitModalAction() {
    _state.isOpenModale = false;
    notifyListeners();
  }
}
