import 'package:crypto_idle/domain/data_providers/my_hive_data_provider.dart';
import 'package:crypto_idle/domain/entities/game.dart';
import 'package:hive/hive.dart';

class GameDataProvider implements MyHiveDataProvider<Game> {
  late Box<Game> _box;

  @override
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

  @override
  Game loadData() {
    return _box.get('main') ?? Game.empty(date: DateTime(0));
  }

  @override
  Future<void> saveData(Game game) async {
    await _box.put('main', game);
  }
}
