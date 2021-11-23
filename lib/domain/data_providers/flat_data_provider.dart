import 'package:crypto_idle/domain/entities/flat.dart';
import 'package:hive/hive.dart';

class FlatDataProvider {
  late Box<Flat> _box;

  Future<void> openBox() async {
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(FlatAdapter());
    }
    if (Hive.isBoxOpen('flat')) {
      _box = Hive.box<Flat>('flat');
    } else {
      _box = await Hive.openBox<Flat>('flat');
    }
  }

  List<Flat> loadData() {
    return _box.values.toList();
  }

  Future<void> saveData(Flat flat) async {
    await _box.add(flat);
  }
}
