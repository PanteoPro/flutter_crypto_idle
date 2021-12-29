import 'dart:async';

import 'package:crypto_idle/config.dart';
import 'package:crypto_idle/domain/entities/flat.dart';
import 'package:crypto_idle/domain/entities/pc.dart';
import 'package:crypto_idle/domain/entities/price_token.dart';
import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/domain/repositories/flat_repository.dart';
import 'package:crypto_idle/domain/repositories/game_repository.dart';
import 'package:crypto_idle/domain/repositories/music_manager.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';
import 'package:crypto_idle/domain/repositories/pc_repository.dart';
import 'package:crypto_idle/domain/repositories/price_token_repository.dart';
import 'package:crypto_idle/domain/repositories/token_repository.dart';
import 'package:crypto_idle/ui/navigators/game_navigator.dart';
import 'package:flutter/cupertino.dart';

class GameViewModelState {
  GameViewModelState({
    required this.date,
    required this.money,
    required this.tokens,
    required this.currentPrices,
    required this.currentFlat,
    required this.gameOver,
    required this.isModalGameOverClose,
    required this.myPCs,
  });
  GameViewModelState.empty({
    this.money = 0,
    this.gameOver = false,
    this.isModalGameOverClose = false,
  }) {
    date = DateTime(0);
    tokens = [];
    currentPrices = {};
    currentFlat = Flat.empty();
    myPCs = [];
  }

  late DateTime date;
  final double money;
  late List<Token> tokens;
  late Map<int, double> currentPrices;
  final bool gameOver;
  bool isModalGameOverClose;
  late List<PC> myPCs;
  late Flat currentFlat;

  double get averageEarnings {
    var result = 0.0;
    for (final pc in myPCs) {
      if (pc.miningToken != null) {
        result += pc.incomeCash;
      }
    }
    return double.parse(result.toStringAsFixed(2));
  }

  double get monthConsume => flatConsume + energyConsumeCost;
  double get flatConsume => currentFlat.costMonth;
  double get energyConsumeCost {
    final sumCostPC = energyConsume / AppConfig.kVisualEnergy;
    return double.parse((sumCostPC * AppConfig.kEnergyPc).toStringAsFixed(2));
  }

  double get energyConsume {
    var energy = 0.0;
    for (final element in myPCs) {
      energy += element.energy;
    }
    return double.parse(energy.toStringAsFixed(2));
  }

  double get powerPCs {
    var power = 0.0;
    for (final element in myPCs) {
      if (element.miningToken != null) {
        power += element.power;
      }
    }
    return power;
  }

  int get maxCountPC => currentFlat.countPC;
  int get currentCountPC => myPCs.length;

  double getPriceByToken(Token token) {
    return currentPrices[token.id]!;
  }

  double get cryptoBalance {
    double balance = 0;
    for (final Token token in tokens) {
      balance += getPriceByToken(token) * token.count;
    }
    return double.parse(balance.toStringAsFixed(2));
  }
}

class GameViewModel extends ChangeNotifier {
  GameViewModel() {
    initialRepository();
  }

  @override
  void dispose() {
    _gameStreamSub?.cancel();
    _pcStreamSub?.cancel();
    _flatStreamSub?.cancel();
    _tokenStreamSub?.cancel();
    _priceTokensStreamSub?.cancel();
    super.dispose();
  }

  // Repositories
  final _gameRepository = GameRepository();
  final _pcRepository = PCRepository();
  final _flatRepository = FlatRepository();
  final _tokensRepository = TokenRepository();
  final _priceTokensRepository = PriceTokenRepository();

  StreamSubscription<dynamic>? _gameStreamSub;
  StreamSubscription<dynamic>? _pcStreamSub;
  StreamSubscription<dynamic>? _flatStreamSub;
  StreamSubscription<dynamic>? _tokenStreamSub;
  StreamSubscription<dynamic>? _priceTokensStreamSub;

  // Data
  late GameViewModelState _state;
  GameViewModelState get state => _state;

  /// Initial Repository
  Future<void> initialRepository() async {
    _state = GameViewModelState.empty();
    await _gameRepository.init();
    await _pcRepository.init();
    await _flatRepository.init();
    await _tokensRepository.init();
    await _priceTokensRepository.init();
    _subscriteStreams();
    updateState();
  }

  /// Subscribes to Repositories streams
  void _subscriteStreams() {
    _gameStreamSub = GameRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _gameRepository));
    _pcStreamSub = PCRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _pcRepository));
    _flatStreamSub = FlatRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _flatRepository));
    _tokenStreamSub =
        TokenRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _tokensRepository));
    _priceTokensStreamSub =
        PriceTokenRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _priceTokensRepository));
  }

  Future<void> _updateRepoByChangeEvent(dynamic data, MyRepository repository) async {
    repository.updateData();
    updateState();
  }

  void updateState() {
    final currentPrices = <int, double>{};
    final currentTokens = _tokensRepository.tokens;
    for (final token in currentTokens) {
      currentPrices[token.id] = _priceTokensRepository.getLatestPriceByTokenId(token.id).cost;
    }

    _endGameSound();

    _state = GameViewModelState(
      tokens: _tokensRepository.tokens,
      myPCs: _pcRepository.pcs,
      currentPrices: currentPrices,
      date: _gameRepository.game.date,
      money: _gameRepository.game.money,
      currentFlat: _flatRepository.currentFlat,
      gameOver: _gameRepository.game.gameOver,
      isModalGameOverClose: _state.isModalGameOverClose,
    );
    notifyListeners();
  }

  void _endGameSound() {
    if (_state.gameOver != _gameRepository.game.gameOver) {
      MusicManager.stopMain();
      MusicManager.playGameOver();
    }
  }

  void onExitGameOverPressed(BuildContext context) {
    // _state.isModalGameOverClose = true;
    // notifyListeners();
    MusicManager.stopMain();
    MusicManager.playMenu();
    Navigator.of(context, rootNavigator: true).pushReplacementNamed('menu');
  }

  void onGoStatisticGameOverPressed(BuildContext context) {
    state.isModalGameOverClose = true;
    notifyListeners();
    Navigator.of(context).pushNamed(GameNavigationRouteNames.statistics, arguments: false);
  }
}
