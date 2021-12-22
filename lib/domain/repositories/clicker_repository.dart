import 'dart:async';

import 'package:crypto_idle/config.dart';
import 'package:crypto_idle/domain/data_providers/clicker_data_provider.dart';
import 'package:crypto_idle/domain/entities/clicker.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';

class ClickerRepository implements MyRepository {
  final _clickerDataProvider = ClickerDataProvider();
  static final _streamController = StreamController<dynamic>();
  static Stream<dynamic>? stream;

  var _clicker = Clicker.start();
  Clicker get clicker => _clicker;

  @override
  Future<void> init() async {
    await _clickerDataProvider.openBox();
    updateData();
    stream ??= _streamController.stream.asBroadcastStream();
  }

  @override
  void updateData() {
    _clicker = _clickerDataProvider.loadData();
  }

  Future<void> _save(String message) async {
    await _clickerDataProvider.saveData(_clicker);
    updateData();
    _streamController.add(message);
  }

  Future<bool> levelUp() async {
    if (_clicker.level < _clicker.maxLevel) {
      final level = _clicker.level + 1;
      final minMoney = AppConfig.minByLevel(level);
      final maxMoney = AppConfig.maxByLevel(level);
      final critMoney = AppConfig.critByLevel(level);
      final probabilityCrit = AppConfig.probabilityByLevel(level);
      final upgradeCost = AppConfig.upgradeCostByLevel(level);
      _clicker = _clicker.copyWith(
        level: level,
        minMoney: minMoney,
        maxMoney: maxMoney,
        critMoney: critMoney,
        probabilityCrit: probabilityCrit,
        upgradeCost: upgradeCost,
      );
      await _save('levelUp');
    }
    return false;
  }

  Future<bool> decreaceClick() async {
    if (_clicker.currentClicks > 0) {
      _clicker = _clicker.copyWith(currentClicks: _clicker.currentClicks - 1);
      await _save('decreace click');
      return true;
    }
    return false;
  }

  Future<void> decreaceDelay() async {
    if (_clicker.currentDelay > 0) {
      _clicker = _clicker.copyWith(secondsDelay: _clicker.currentDelay - 1);
      await _save('decreace delay');
    }
  }

  Future<void> restoreClicks() async {
    _clicker = _clicker.copyWith(currentClicks: _clicker.maxClicks);
    await _save('restore clicks');
  }

  Future<void> restoreDelay() async {
    _clicker = _clicker.copyWith(secondsDelay: _clicker.maxDelay);
    await _save('restore clicks');
  }
}
