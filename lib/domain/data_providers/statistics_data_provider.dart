import 'package:crypto_idle/domain/entities/statistics.dart';
import 'package:hive/hive.dart';

class StatisticsDataProvider {
  late Box<Statistics> _box;

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

  Future<void> saveStatistics(Statistics stat) async {
    await stat.save();
  }

  Statistics loadStatistics() {
    return _box.values.first;
  }
}
