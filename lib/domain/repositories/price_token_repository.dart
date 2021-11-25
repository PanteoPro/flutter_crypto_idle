import 'package:crypto_idle/domain/data_providers/price_token_data_provider.dart';
import 'package:crypto_idle/domain/entities/price_token.dart';

class PriceTokenRepository {
  final _priceTokenDataProvider = PriceTokenDataProvider();

  var _prices = <PriceToken>[];
  List<PriceToken> get prices => List.unmodifiable(_prices);
  List<PriceToken> pricesByTokenId(int tokenId) => _prices.where((element) => element.tokenId == tokenId).toList();
  PriceToken getLatestPriceByTokenId(int tokenId) => pricesByTokenId(tokenId).last;

  Future<void> init() async {
    await _priceTokenDataProvider.openBox();
    _updateData();
  }

  void _updateData() {
    _prices = _priceTokenDataProvider.loadAllPrices();
  }

  Future<void> addPrice(PriceToken price) async {
    await _priceTokenDataProvider.savePrice(price);
  }
}
