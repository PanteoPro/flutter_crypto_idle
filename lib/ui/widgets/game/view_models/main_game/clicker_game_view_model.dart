import 'dart:async';
import 'dart:math';

import 'package:crypto_idle/domain/entities/clicker.dart';
import 'package:crypto_idle/domain/repositories/clicker_repository.dart';
import 'package:crypto_idle/domain/repositories/game_repository.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';
import 'package:flutter/cupertino.dart';

class ClickerGameViewModelState {
  ClickerGameViewModelState({
    required this.clicker,
  });
  final Clicker clicker;

  double get percentCurrentClicks => clicker.currentClicks / clicker.maxClicks;
  double get percentCurrentDelay => (clicker.maxDelay - clicker.currentDelay) / clicker.maxDelay;
  String get currentDelayString {
    var minutes = 0;
    var seconds = 0;
    if (clicker.currentClicks == 0) {
      minutes = (clicker.currentDelay / 60).floor();
      seconds = clicker.currentDelay - minutes * 60;
    }
    final minutesString = minutes < 10 ? '0$minutes' : '$minutes';
    final secondsString = seconds < 10 ? '0$seconds' : '$seconds';
    return '$minutesString:$secondsString';
  }
}

class ClickerGameViewModel extends ChangeNotifier {
  ClickerGameViewModel() {
    _initialRepositories();
  }

  @override
  void dispose() {
    _delayClickerPCSub?.cancel();
    _clickerStreamSub?.cancel();
    super.dispose();
  }

  Future<void> _initialRepositories() async {
    await _clickerRepository.init();
    await _gameRepository.init();
    _clickerStreamSub =
        ClickerRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _clickerRepository));
    await _updateState();
    _subscribeOnDelayClickablePc(true);
  }

  Future<void> _updateRepoByChangeEvent(dynamic data, MyRepository repository) async {
    repository.updateData();
    _updateState();
  }

  Future<void> _updateState() async {
    _state = ClickerGameViewModelState(
      clicker: _clickerRepository.clicker,
    );
    notifyListeners();
  }

  var _state = ClickerGameViewModelState(clicker: Clicker.start());
  ClickerGameViewModelState get state => _state;

  final _clickerRepository = ClickerRepository();
  final _gameRepository = GameRepository();
  StreamSubscription<dynamic>? _clickerStreamSub;

  StreamSubscription<dynamic>? _delayClickerPCSub;

  double getRandomMoney() {
    final rnd = Random();
    final isCrit = rnd.nextDouble() <= _state.clicker.probabilityCrit;
    if (isCrit) {
      return _state.clicker.critMoney;
    } else {
      return double.parse(
        (_state.clicker.minMoney + rnd.nextDouble() * (_state.clicker.maxMoney - _state.clicker.minMoney))
            .toStringAsFixed(2),
      );
    }
  }

  Future<bool> onClickerPcPressed(double rndMoney) async {
    await _clickerRepository.decreaceClick();
    if (_clickerRepository.clicker.currentClicks > 0) {
      await _gameRepository.addMoney(rndMoney);
      _updateState();
      return true;
    } else {
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
}
