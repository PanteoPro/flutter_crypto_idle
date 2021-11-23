import 'package:crypto_idle/domain/entities/game.dart';
import 'package:hive/hive.dart';

class GameDataProvider {
  late Box<Game> _box;

  Future<void> openBox() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(GameAdapter());
    }
    if (Hive.isBoxOpen('game')) {
      _box = Hive.box<Game>('game');
    } else {
      _box = await Hive.openBox<Game>('game');
    }
  }

  Future<Game> loadData() async {
    return _box.get('main') ?? Game.empty();
  }

  Future<void> saveData(Game game) async {
    await _box.put('main', game);
  }
}
