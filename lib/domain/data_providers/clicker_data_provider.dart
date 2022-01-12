import 'package:crypto_tycoon/domain/data_providers/my_hive_data_provider.dart';
import 'package:crypto_tycoon/domain/entities/clicker.dart';
import 'package:hive/hive.dart';

class ClickerDataProvider implements MyHiveDataProvider<Clicker> {
  late Box<Clicker> _box;

  @override
  Future<void> openBox() async {
    if (!Hive.isAdapterRegistered(7)) {
      Hive.registerAdapter(ClickerAdapter());
    }
    if (Hive.isBoxOpen('clicker')) {
      _box = Hive.box<Clicker>('clicker');
    } else {
      _box = await Hive.openBox<Clicker>('clicker');
    }
  }

  @override
  Future<void> saveData(Clicker instance) async {
    await _box.put(0, instance);
  }

  @override
  Clicker loadData() {
    return _box.get(0) ?? Clicker.start();
  }
}
