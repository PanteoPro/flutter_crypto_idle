import 'package:crypto_idle/domain/data_providers/my_hive_data_provider.dart';
import 'package:crypto_idle/domain/entities/news.dart';
import 'package:hive/hive.dart';

class NewsDataProvider implements MyHiveDataProvider<News> {
  late Box<News> _box;

  @override
  Future<void> openBox() async {
    if (!Hive.isAdapterRegistered(6)) {
      Hive.registerAdapter(NewsAdapter());
    }
    if (Hive.isBoxOpen('news')) {
      _box = Hive.box<News>('news');
    } else {
      _box = await Hive.openBox<News>('news');
    }
  }

  @override
  List<News> loadData() {
    return _box.values.toList();
  }

  @override
  Future<void> saveData(News news) async {
    await _box.add(news);
  }
}
