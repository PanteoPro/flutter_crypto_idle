import 'package:crypto_idle/domain/entities/price_token.dart';
import 'package:hive/hive.dart';

class PriceTokenDataProvider {
  late Box<PriceToken> _box;

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

  Future<void> savePrice(PriceToken price) async {
    await _box.add(price);
  }

  List<PriceToken> loadAllPrices() {
    return _box.values.toList();
  }
}
