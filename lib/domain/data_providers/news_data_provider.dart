import 'package:crypto_idle/domain/entities/news.dart';
import 'package:hive/hive.dart';

class NewsDataProvider {
  late Box<News> _box;

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

  Future<List<News>> loadData() async {
    return _box.values.toList();
  }

  Future<void> saveData(News news) async {
    await _box.add(news);
  }
}
