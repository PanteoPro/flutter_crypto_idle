import 'dart:async';
import 'dart:math';
import 'package:collection/collection.dart';
import 'package:crypto_idle/config.dart';
import 'package:crypto_idle/domain/entities/flat.dart';
import 'package:crypto_idle/domain/entities/game.dart';
import 'package:crypto_idle/domain/entities/pc.dart';
import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/domain/repositories/flat_repository.dart';
import 'package:crypto_idle/domain/repositories/game_repository.dart';
import 'package:crypto_idle/domain/repositories/message_manager.dart';

import 'package:crypto_idle/domain/repositories/my_repository.dart';
import 'package:crypto_idle/domain/repositories/pc_repository.dart';
import 'package:crypto_idle/domain/repositories/price_token_repository.dart';
import 'package:crypto_idle/domain/repositories/token_repository.dart';
import 'package:crypto_idle/initial_data.dart';
import 'package:crypto_idle/ui/navigators/game_navigator.dart';
import 'package:crypto_idle/ui/navigators/main_navigator.dart';
import 'package:flutter/cupertino.dart';

import 'package:crypto_idle/domain/entities/statistics.dart';
import 'package:crypto_idle/domain/repositories/statistics_repository.dart';
import 'package:flutter/material.dart';

class MainGameViewModelState {
  MainGameViewModelState({
    required this.statistics,
    required this.tokens,
    required this.myPCs,
    required this.flat,
    required this.isModalShow,
    required this.date,
    required this.money,
    required this.currentPrices,
    required this.currentClicks,
    required this.currentDelay,
  });
  MainGameViewModelState.empty({
    Statistics? statistics,
    List<Token>? tokens,
    List<PC>? myPCs,
    Flat? flat,
    bool? isModalShow,
    DateTime? date,
    this.money = 0,
    this.currentClicks = 0,
    this.currentDelay = 0,
    this.currentPrices = const {},
  }) {
    this.statistics = statistics ?? Statistics.empty();
    this.tokens = tokens ?? [];
    this.myPCs = myPCs ?? [];
    this.flat = flat ?? Flat.empty();
    this.isModalShow = isModalShow ?? false;
    this.date = date ?? DateTime.now();
  }

  late Statistics statistics;
  late List<Token> tokens;
  late List<PC> myPCs;
  late Flat flat;
  late DateTime date;
  late double money;
  final Map<int, double> currentPrices;

  final int currentClicks;
  final int currentDelay;
  double get percentCurrentClicks => currentClicks / Game.maxClicks;
  double get percentCurrentDelay => (Game.maxDelay - currentDelay) / Game.maxDelay;
  String get currentDelayString {
    var minutes = 0;
    var seconds = 0;
    if (currentClicks == 0) {
      minutes = (currentDelay / 60).floor();
      seconds = currentDelay - minutes * 60;
    }
    final minutesString = minutes < 10 ? '0$minutes' : '$minutes';
    final secondsString = seconds < 10 ? '0$seconds' : '$seconds';
    return '$minutesString:$secondsString';
  }

  double get monthConsume => flatConsume + energyConsumeCost;
  double get flatConsume => flat.costMonth;
  double get energyConsumeCost {
    final sumCostPC = energyConsume / AppConfig.kVisualEnergy;
    return double.parse((sumCostPC * AppConfig.kEnergyPc).toStringAsFixed(2));
  }

  double get energyConsume {
    var energy = 0.0;
    for (final element in myPCs) {
      if (element.miningToken != null) {
        energy += element.energy;
      }
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

  bool isModalShow = false;

  double get sumFlatConsume => statistics.flatConsume.sum;
  double get sumEnergyConsume => statistics.energyConsume.sum;
  double get sumPCConsume => statistics.pcConsume.sum;
  double get sumConsume => sumFlatConsume + sumEnergyConsume + sumPCConsume;

  double earnTokensByTokenId(int tokenId) {
    return statistics.tokenEarn[tokenId]?.sum ?? 0;
  }

  double miningTokensByTokenId(int tokenId) {
    return statistics.tokenMining[tokenId]?.sum ?? 0;
  }
}

class MainGameViewModel extends ChangeNotifier {
  MainGameViewModel() {
    _initialRepositories();
  }

  @override
  void dispose() {
    _gameStreamSub?.cancel();
    _statisticsStreamSub?.cancel();
    _tokensStreamSub?.cancel();
    _flatStreamSub?.cancel();
    _pcStreamSub?.cancel();
    _priceTokenStreamSub?.cancel();
    _delayClickerPCSub?.cancel();
    super.dispose();
  }

  final _gameRepository = GameRepository();
  final _statisticsRepository = StatisticsRepository();
  final _tokensRepository = TokenRepository();
  final _flatRepository = FlatRepository();
  final _pcRepository = PCRepository();
  final _priceTokenRepository = PriceTokenRepository();
  StreamSubscription<dynamic>? _gameStreamSub;
  StreamSubscription<dynamic>? _statisticsStreamSub;
  StreamSubscription<dynamic>? _tokensStreamSub;
  StreamSubscription<dynamic>? _flatStreamSub;
  StreamSubscription<dynamic>? _pcStreamSub;
  StreamSubscription<dynamic>? _priceTokenStreamSub;

  var _state = MainGameViewModelState.empty();
  MainGameViewModelState get state => _state;

  static const daysUntilTheEndOfMonth = 7;
  DateTime lastNotifyDate = DateTime.now();

  StreamSubscription<dynamic>? _delayClickerPCSub;
  static const double _minRandomMoney = 0.01;
  static const double _maxRandomMoney = 0.10;
  static const double critRandomMoney = 100;
  static const double _probabilityCritRandomMoney = 0.1;
  static double getRandomMoney() {
    final rnd = Random();
    final isCrit = rnd.nextDouble() <= _probabilityCritRandomMoney;
    if (isCrit) {
      return critRandomMoney;
    } else {
      return double.parse(
          (_minRandomMoney + rnd.nextDouble() * (_maxRandomMoney - _minRandomMoney)).toStringAsFixed(2));
    }
  }

  Future<void> _initialRepositories() async {
    await _gameRepository.init();
    await _statisticsRepository.init();
    await _tokensRepository.init();
    await _flatRepository.init();
    await _pcRepository.init();
    await _priceTokenRepository.init();
    _subscriteStreams();
    _subscribeOnDelayClickablePc(true);
    await _updateState();
  }

  void _subscriteStreams() {
    _gameStreamSub = GameRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _gameRepository));
    _statisticsStreamSub =
        StatisticsRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _statisticsRepository));
    _tokensStreamSub =
        TokenRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _tokensRepository));
    _flatStreamSub = FlatRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _flatRepository));
    _pcStreamSub = PCRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _pcRepository));
    _priceTokenStreamSub =
        PriceTokenRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _priceTokenRepository));
  }

  Future<void> _updateRepoByChangeEvent(dynamic data, MyRepository repository) async {
    repository.updateData();
    if (repository.runtimeType == GameRepository) {
      _checkForEnoughtMoneyForPayments();
    }
    _updateState();
  }

  void _checkForEnoughtMoneyForPayments() {
    final currentDate = _gameRepository.game.date;
    final endMonthDate = DateTime(currentDate.year, currentDate.month + 1);
    if (currentDate.isAfter(endMonthDate.add(const Duration(days: -daysUntilTheEndOfMonth))) &&
        currentDate != lastNotifyDate) {
      if (state.monthConsume > state.money) {
        lastNotifyDate = currentDate;
        MessageManager.addMessage(
          text:
              'У вас не хватает денег для месячной оплаты, найдите ${state.monthConsume - state.money}\$, или проиграете!',
          color: Colors.red,
        );
      }
    }
  }

  Future<void> _updateState() async {
    final currentPrices = <int, double>{};
    final currentTokens = _tokensRepository.tokens;
    for (final token in currentTokens) {
      currentPrices[token.id] = _priceTokenRepository.getLatestPriceByTokenId(token.id).cost;
    }
    _state = MainGameViewModelState(
      statistics: _statisticsRepository.statistics,
      tokens: _tokensRepository.tokens,
      flat: _flatRepository.currentFlat,
      myPCs: _pcRepository.pcs,
      isModalShow: _state.isModalShow,
      date: _gameRepository.game.date,
      money: _gameRepository.game.money,
      currentPrices: currentPrices,
      currentClicks: _gameRepository.game.currentClicks,
      currentDelay: _gameRepository.game.secondsDelay,
    );
    notifyListeners();
  }

  void onReturnToMenuButtonPressed() {
    _state.isModalShow = !_state.isModalShow;
    notifyListeners();
  }

  void onYesExitButtonPressed(BuildContext context) {
    final mainNavigator = context.findRootAncestorStateOfType<NavigatorState>();
    mainNavigator?.pushReplacementNamed(MainNavigationRouteNames.menu);
  }

  void onNoExitButtonPressed() {
    _state.isModalShow = false;
    notifyListeners();
  }

  Future<bool> onClickerPcPressed(double rndMoney) async {
    await _gameRepository.decreaceClick();
    if (_gameRepository.game.currentClicks > 0) {
      await _gameRepository.changeData(money: _state.money + rndMoney);
      _updateState();
      return true;
    } else {
      _subscribeOnDelayClickablePc();
    }
    return false;
  }

  void _subscribeOnDelayClickablePc([bool isInitial = false]) {
    if (_gameRepository.game.secondsDelay == 0 && !isInitial || isInitial && _gameRepository.game.secondsDelay > 0) {
      final stream = Stream.periodic(const Duration(seconds: 1));
      if (!isInitial) {
        _gameRepository.restoreDelay();
      }
      _delayClickerPCSub = stream.listen(_checkEndDelayClickablePc);
    }
  }

  Future<void> _checkEndDelayClickablePc(dynamic event) async {
    if (_gameRepository.game.secondsDelay != 0) {
      await _gameRepository.decreaceDelay();
    }
    if (_gameRepository.game.secondsDelay == 0) {
      _delayClickerPCSub!.cancel();
      await _gameRepository.restoreClicks();
    }
    _updateState();
  }

  void BABLO() {
    _gameRepository.changeData(money: _state.money + 100);
  }

  void onBuyPcButtonPressed(BuildContext context) {
    Navigator.of(context).pushNamed(GameNavigationRouteNames.marketPC);
  }

  void onBuyFlatButtonPressed(BuildContext context) {
    Navigator.of(context).pushNamed(GameNavigationRouteNames.marketFlat);
  }

  void onWalletButtonPressed(BuildContext context) {
    Navigator.of(context).pushNamed(GameNavigationRouteNames.crypto);
  }

  void onStatisticButtonPressed(BuildContext context) {
    Navigator.of(context).pushNamed(GameNavigationRouteNames.mining);
  }
}
