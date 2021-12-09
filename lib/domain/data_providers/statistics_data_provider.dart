import 'package:crypto_idle/domain/data_providers/my_hive_data_provider.dart';
import 'package:crypto_idle/domain/entities/statistics.dart';
import 'package:hive/hive.dart';

class StatisticsDataProvider implements MyHiveDataProvider<Statistics> {
  late Box<Statistics> _box;

  @override
  Future<void> openBox() async {
    if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(StatisticsAdapter());
    }
    if (Hive.isBoxOpen('statistics')) {
      _box = Hive.box<Statistics>('statistics');
    } else {
      _box = await Hive.openBox<Statistics>('statistics');
    }
  }

  @override
  Statistics loadData() {
    return _box.get(0) ?? Statistics.empty();
  }

  @override
  Future<void> saveData(Statistics stat) async {
    await _box.put(0, stat);
    // await stat.save();
  }
}
