import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:crypto_idle/domain/entities/pc.dart';
import 'package:crypto_idle/domain/entities/price_token.dart';
import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';
import 'package:crypto_idle/domain/repositories/pc_repository.dart';
import 'package:crypto_idle/domain/repositories/price_token_repository.dart';
import 'package:crypto_idle/domain/repositories/token_repository.dart';

class GameMiningViewModelState {
  GameMiningViewModelState({
    required this.tokens,
    required this.prices,
    required this.pcs,
    bool? isOpenModale,
    int? modaleTokenIndex,
  }) {
    if (isOpenModale != null) {
      this.isOpenModale = isOpenModale;
    }
    if (modaleTokenIndex != null) {
      this.modaleTokenIndex = modaleTokenIndex;
    }
  }
  GameMiningViewModelState.empty({
    this.tokens = const [],
    this.prices = const [],
    this.pcs = const [],
  });

  final List<Token> tokens;
  final List<PriceToken> prices;
  final List<PC> pcs;
  List<PC>? filtered;

  bool isOpenModale = false;
  int modaleTokenIndex = 0;

  PriceToken getCurrentPriceByToken(Token token) {
    return prices.where((price) => price.tokenId == token.id).last;
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
  }) {
    return GameMiningViewModelState(
      tokens: tokens ?? this.tokens,
      prices: prices ?? this.prices,
      pcs: pcs ?? this.pcs,
      isOpenModale: isOpenModale ?? this.isOpenModale,
      modaleTokenIndex: modaleTokenIndex ?? this.modaleTokenIndex,
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
    super.dispose();
  }

  // Repositories
  final _tokenRepository = TokenRepository();
  final _priceTokenRepository = PriceTokenRepository();
  final _pcRepository = PCRepository();
  StreamSubscription<dynamic>? _tokenStreamSub;
  StreamSubscription<dynamic>? _priceStreamSub;
  StreamSubscription<dynamic>? _pcStreamSub;

  // Data
  var _state = GameMiningViewModelState.empty();
  GameMiningViewModelState get state => _state;

  /// Initial Repository
  Future<void> initialRepositories() async {
    await _tokenRepository.init();
    await _priceTokenRepository.init();
    await _pcRepository.init();

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
  }

  Future<void> _updateRepoByChangeEvent(dynamic data, MyRepository repository) async {
    await repository.updateData();
    _updateState();
  }

  void _updateState() {
    _state = _state.copyWith(
      tokens: _tokenRepository.tokens,
      prices: _priceTokenRepository.prices,
      pcs: _pcRepository.pcs,
    );
    notifyListeners();
  }

  void onChangeMiningToken(int pcIndex) {
    final pc = _state.filtered![pcIndex];
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
    _state.sortedPCFirstEmpty();
    notifyListeners();
  }

  void onExitModalAction() {
    _state.isOpenModale = false;
    notifyListeners();
  }
}
