import 'dart:async';
import 'dart:math';

import 'package:crypto_idle/domain/entities/clicker.dart';
import 'package:crypto_idle/domain/repositories/clicker_repository.dart';
import 'package:crypto_idle/domain/repositories/game_repository.dart';
import 'package:crypto_idle/domain/repositories/music_manager.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';
import 'package:crypto_idle/domain/repositories/statistics_manager.dart';
import 'package:flutter/material.dart';

class ClickerGameViewModelState {
  ClickerGameViewModelState({
    required this.clicker,
    required this.isModalUpgrade,
    required this.isReward,
    required this.rewardSeconds,
  });
  final Clicker clicker;
  bool isModalUpgrade;
  bool isReward;
  int rewardSeconds;

  double get percentCurrentClicks => clicker.currentClicks / clicker.maxClicks;
  double get percentCurrentDelay => (clicker.maxDelay - clicker.currentDelay) / clicker.maxDelay;
  String get currentDelayString {
    return secondsToString(clicker.currentDelay);
  }

  static String secondsToString(int initSeconds) {
    final minutes = (initSeconds / 60).floor();
    final seconds = initSeconds - minutes * 60;
    final minutesString = minutes < 10 ? '0$minutes' : '$minutes';
    final secondsString = seconds < 10 ? '0$seconds' : '$seconds';
    return '$minutesString:$secondsString';
  }

  double getRandomMoney() {
    final rnd = Random();
    final isCrit = rnd.nextDouble() <= clicker.probabilityCrit;
    if (isCrit) {
      return clicker.critMoney;
    } else {
      return double.parse(
        (clicker.minMoney + rnd.nextDouble() * (clicker.maxMoney - clicker.minMoney)).toStringAsFixed(2),
      );
    }
  }
}

class ClickerGameViewModel extends ChangeNotifier {
  ClickerGameViewModel() {
    _initialRepositories();
  }

  // ----- Core logic -----

  @override
  void dispose() {
    _delayClickerPCSub?.cancel();
    _gameStreamSub?.cancel();
    super.dispose();
  }

  Future<void> _initialRepositories() async {
    await _clickerRepository.init();
    await _gameRepository.init();
    _gameStreamSub = GameRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _gameRepository));
    await _updateState();
    _subscribeOnDelayClickablePc(true);
  }

  Future<void> _updateRepoByChangeEvent(dynamic data, MyRepository repository) async {
    if (repository.runtimeType == GameRepository) {
      if (data != GameRepositoryStreamEvents.clickerMoney) {
        repository.updateData();
        _updateState();
      }
    }
  }

  Future<void> _updateState() async {
    _state = ClickerGameViewModelState(
      clicker: _clickerRepository.clicker,
      isModalUpgrade: _state.isModalUpgrade,
      isReward: _state.isReward,
      rewardSeconds: _state.rewardSeconds,
    );
    notifyListeners();
  }

  // END ----- Core logic -----

  // ----- Fields -----

  var _state = ClickerGameViewModelState(
    clicker: Clicker.start(),
    isModalUpgrade: false,
    isReward: false,
    rewardSeconds: 0,
  );
  ClickerGameViewModelState get state => _state;

  final _clickerRepository = ClickerRepository();
  final _gameRepository = GameRepository();
  StreamSubscription<GameRepositoryStreamEvents>? _gameStreamSub;

  StreamSubscription<dynamic>? _delayClickerPCSub;

  // END ----- Fields -----

  // ----- Clicker Logic -----

  void pauseDelayClicker() {
    _delayClickerPCSub?.pause();
  }

  void resumeDelayClicker() {
    _delayClickerPCSub?.resume();
  }

  void onGetReward(int seconds) {
    if (!state.isReward) {
      state.isReward = true;
      state.rewardSeconds = seconds;
      _updateState();
    }
  }

  void onUseReward() {
    state.isReward = false;
    state.rewardSeconds = 0;
    // _updateState();
  }

  Future<void> rewardGetMoney(double rndMoney) async {
    await _gameRepository.clickerMoney(rndMoney);
    _updateState();
  }

  Future<bool> onClickerPcPressed(double rndMoney) async {
    final beforeDecreaceClicks = _clickerRepository.clicker.currentClicks;
    if (await _clickerRepository.decreaceClick()) {
      StatisticsManager.sendMessageStream(
        StatisticsManagerStreamEvents(
          state: StatisticsManagerStreamState.addClickerPc,
        ),
      );
      StatisticsManager.sendMessageStream(
        StatisticsManagerStreamEvents(
          state: StatisticsManagerStreamState.addClickerEarn,
          value: rndMoney,
        ),
      );
      if (rndMoney == _clickerRepository.clicker.critMoney) {
        StatisticsManager.sendMessageStream(
          StatisticsManagerStreamEvents(
            state: StatisticsManagerStreamState.addClickerCrit,
          ),
        );
      }
      MusicManager.playClickPc();
    }
    if (_clickerRepository.clicker.currentClicks > 0) {
      await _gameRepository.clickerMoney(rndMoney);
      _updateState();
      return true;
    } else {
      if (beforeDecreaceClicks == 1) {
        await _gameRepository.changeMoney(rndMoney);
        _updateState();
      }
      _subscribeOnDelayClickablePc();
    }
    return false;
  }

  void _subscribeOnDelayClickablePc([bool isInitial = false]) {
    final isNotStartDelayInNotInitialSubscribe = _state.clicker.currentDelay == 0 && !isInitial;
    final isHaveDelayAndInitialSubscribe = isInitial && _state.clicker.currentDelay > 0;
    final isHaveSubscribe = _delayClickerPCSub != null;
    if ((isNotStartDelayInNotInitialSubscribe || isHaveDelayAndInitialSubscribe) && !isHaveSubscribe) {
      final stream = Stream.periodic(const Duration(seconds: 1));
      if (!isInitial) {
        _clickerRepository.restoreDelay();
      }
      _delayClickerPCSub = stream.listen(_checkEndDelayClickablePc);
    }
  }

  Future<void> _checkEndDelayClickablePc(dynamic event) async {
    if (_clickerRepository.clicker.currentDelay != 0) {
      await _clickerRepository.decreaceDelay();
    }
    if (_clickerRepository.clicker.currentDelay == 0) {
      _delayClickerPCSub!.cancel();
      _delayClickerPCSub = null;
      await _clickerRepository.restoreClicks();
    }
    _updateState();
  }

  // END ----- Clicker Logic -----

  // ----- Upgrade Logic -----

  Future<bool> onClickUpgradeButton() async {
    _gameRepository.updateData();
    final upgradeCost = _clickerRepository.clicker.upgradeCost;
    if (_gameRepository.game.money >= upgradeCost) {
      if (await _clickerRepository.levelUp()) {
        MusicManager.playClick();
        _gameRepository.changeMoney(-upgradeCost);
        return true;
      } else {
        // max LEvel
      }
    } else {
      print(
          'not enought money. you have ${_gameRepository.game.money}, need ${_clickerRepository.clicker.upgradeCost}');
      // not enough money
    }
    return false;
  }

  void onOpenModal() {
    MusicManager.playClick();
    state.isModalUpgrade = true;
    notifyListeners();
  }

  void onCloseModal() {
    MusicManager.playClick();
    state.isModalUpgrade = false;
    notifyListeners();
  }
}
