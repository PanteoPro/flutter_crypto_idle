import 'dart:async';

import 'package:crypto_idle/domain/data_providers/price_token_data_provider.dart';
import 'package:crypto_idle/domain/entities/price_token.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';

class PriceTokenRepository implements MyRepository {
  final _priceTokenDataProvider = PriceTokenDataProvider();
  static final _streamController = StreamController<dynamic>();
  static Stream<dynamic>? stream;

  var _prices = <PriceToken>[];
  List<PriceToken> get prices => List.unmodifiable(_prices);
  List<PriceToken> pricesByTokenId(int tokenId) => _prices.where((element) => element.tokenId == tokenId).toList();
  PriceToken getLatestPriceByTokenId(int tokenId) => pricesByTokenId(tokenId).last;

  Future<void> init() async {
    await _priceTokenDataProvider.openBox();
    await updateData();
    stream ??= _streamController.stream.asBroadcastStream();
  }

  Future<void> updateData() async {
    _prices = _priceTokenDataProvider.loadAllPrices();
  }

  Future<void> addPrice(PriceToken price) async {
    await _priceTokenDataProvider.savePrice(price);
    await updateData();
    _streamController.add('AddPrice');
  }
}
