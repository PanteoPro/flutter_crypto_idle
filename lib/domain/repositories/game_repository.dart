import 'package:crypto_idle/domain/data_providers/game_data_provider.dart';
import 'package:crypto_idle/domain/entities/game.dart';

class GameRepository {
  final _gameDataProvider = GameDataProvider();
  var _game = Game.empty();
  Game get game => _game;

  Future<void> init() async {
    await _gameDataProvider.openBox();
    // await changeData(money: 100000);
    _game = await _gameDataProvider.loadData();
  }

  Future<void> changeData({
    double? money,
    String? nick,
  }) async {
    if (money != null) {
      _game = _game.copyWith(money: double.parse(money.toStringAsFixed(2)));
    }
    if (nick != null) {
      _game = _game.copyWith(nick: nick);
    }
    if (money != null || nick != null) {
      await _gameDataProvider.saveData(_game);
    }
  }
}
