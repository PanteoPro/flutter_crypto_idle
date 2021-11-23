import 'package:crypto_idle/domain/data_providers/game_data_provider.dart';
import 'package:crypto_idle/domain/entities/game.dart';
import 'package:crypto_idle/domain/entities/pc.dart';

class GameRepository {
  final _gameDataProvider = GameDataProvider();
  var _game = Game.empty();
  Game get game => _game;

  Future<void> init() async {
    await _gameDataProvider.openBox();
    // await changeData(money: 150);
    await loadData();
  }

  Future<void> loadData() async {
    _game = await _gameDataProvider.loadData();
  }

  Future<void> changeData({double? money, String? nick}) async {
    if (money != null) {
      _game = _game.copyWith(money: money);
    }
    if (nick != null) {
      _game = _game.copyWith(nick: nick);
    }
    if (money != null || nick != null) {
      await _gameDataProvider.saveData(_game);
    }
  }
}
