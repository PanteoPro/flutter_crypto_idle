import 'dart:async';

import 'package:crypto_idle/domain/data_providers/game_data_provider.dart';
import 'package:crypto_idle/domain/entities/game.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';

class GameRepository implements MyRepository {
  final _gameDataProvider = GameDataProvider();

  static final _streamController = StreamController<dynamic>();
  static Stream<dynamic>? stream;

  var _game = Game.empty(date: DateTime(0));
  Game get game => _game;

  @override
  Future<void> init() async {
    await _gameDataProvider.openBox();
    updateData();
    stream ??= _streamController.stream.asBroadcastStream();
  }

  @override
  void updateData() {
    _game = _gameDataProvider.loadData();
  }

  Future<void> addMoney(double money) async {
    _game = _game.copyWith(money: double.parse((_game.money + money).toStringAsFixed(2)));
    await _save('Add Money');
  }

  Future<void> changeData({
    double? money,
    String? nick,
    DateTime? date,
    bool? gameOver,
  }) async {
    if (money != null) {
      _game = _game.copyWith(money: double.parse(money.toStringAsFixed(2)));
    }
    if (nick != null) {
      _game = _game.copyWith(nick: nick);
    }
    if (date != null) {
      _game = _game.copyWith(date: date);
    }
    if (gameOver != null) {
      _game = _game.copyWith(gameOver: gameOver);
    }
    if (money != null || nick != null || date != null || gameOver != null) {
      await _save('change date');
    }
  }

  Future<void> nextDay() async {
    _game = _game.copyWith(date: _game.date.add(const Duration(days: 1)));
    await _save('next day');
  }

  Future<void> _save(String message) async {
    await _gameDataProvider.saveData(_game);
    updateData();
    _streamController.add(message);
  }
}
