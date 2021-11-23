import 'package:crypto_idle/domain/entities/game.dart';
import 'package:hive/hive.dart';

class GameDataProvider {
  final _box = Hive.openBox<Game>('game');

  Future<Game> loadData() async {
    _checkAndSetAdapter();
    final game = (await _box).get('main') ?? Game.empty();
    return game;
  }

  Future<void> saveData(Game game) async {
    _checkAndSetAdapter();
    await (await _box).put('main', game);
  }

  void _checkAndSetAdapter() {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(GameAdapter());
    }
  }
}
