import 'package:crypto_idle/domain/data_providers/game_data_provider.dart';
import 'package:crypto_idle/domain/entities/game.dart';

class GameRepository {
  final _gameDataProvider = GameDataProvider();
  var _game = Game.empty(date: DateTime(0));
  Game get game => _game;

  Future<void> init() async {
    await _gameDataProvider.openBox();
    // await changeData(money: 100000);
    _game = await _gameDataProvider.loadData();
  }

  Future<void> changeData({
    double? money,
    String? nick,
    DateTime? date,
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
    if (money != null || nick != null || date != null) {
      await _gameDataProvider.saveData(_game);
    }
  }

  Future<void> nextDay() async {
    _game = _game.copyWith(date: _game.date.add(const Duration(days: 1)));
    await _gameDataProvider.saveData(_game);
  }
}
