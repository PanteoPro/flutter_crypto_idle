import 'package:crypto_idle/domain/data_providers/my_hive_data_provider.dart';
import 'package:crypto_idle/domain/entities/flat.dart';
import 'package:hive/hive.dart';

class FlatDataProvider implements MyHiveDataProvider<Flat> {
  late Box<Flat> _box;

  @override
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

  @override
  List<Flat> loadData() {
    return _box.values.toList();
  }

  @override
  Future<void> saveData(Flat flat) async {
    await _box.add(flat);
  }
}
