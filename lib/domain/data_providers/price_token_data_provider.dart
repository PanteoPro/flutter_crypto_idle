import 'package:crypto_idle/domain/data_providers/my_hive_data_provider.dart';
import 'package:crypto_idle/domain/entities/price_token.dart';
import 'package:hive/hive.dart';

class PriceTokenDataProvider implements MyHiveDataProvider<PriceToken> {
  late Box<PriceToken> _box;

  @override
  Future<void> openBox() async {
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(PriceTokenAdapter());
    }
    if (Hive.isBoxOpen('price_token')) {
      _box = Hive.box<PriceToken>('price_token');
    } else {
      _box = await Hive.openBox<PriceToken>('price_token');
    }
  }

  @override
  List<PriceToken> loadData() {
    return _box.values.toList();
  }

  @override
  Future<void> saveData(PriceToken price) async {
    await _box.add(price);
  }
}
