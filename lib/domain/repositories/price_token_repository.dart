import 'dart:async';

import 'package:crypto_tycoon/domain/data_providers/price_token_data_provider.dart';
import 'package:crypto_tycoon/domain/entities/price_token.dart';
import 'package:crypto_tycoon/domain/entities/token.dart';
import 'package:crypto_tycoon/domain/repositories/my_repository.dart';
import 'package:crypto_tycoon/initial_data.dart';

enum PriceTokenRepositoryStreamEvents { addPrice, addInitialPrices }

class PriceTokenRepository implements MyRepository {
  final _priceTokenDataProvider = PriceTokenDataProvider();
  static final _streamController = StreamController<dynamic>();
  static Stream<dynamic>? stream;

  var _prices = <PriceToken>[];
  List<PriceToken> get prices => List.unmodifiable(_prices);
  List<PriceToken> pricesByTokenId(int tokenId) => _prices.where((element) => element.tokenId == tokenId).toList();
  PriceToken getLatestPriceByTokenId(int tokenId) => pricesByTokenId(tokenId).last;

  @override
  Future<void> init() async {
    await _priceTokenDataProvider.openBox();
    updateData();
    stream ??= _streamController.stream.asBroadcastStream();
  }

  @override
  void updateData() {
    _prices = _priceTokenDataProvider.loadData();
  }

  Future<void> addPrice(PriceToken price) async {
    final priceNew = price.copyWith(cost: double.parse(price.cost.toStringAsFixed(4)));
    await _priceTokenDataProvider.saveData(priceNew);
    updateData();
    _streamController.add(PriceTokenRepositoryStreamEvents.addPrice);
  }

  Future<void> addInitialPricesForToken(Token token, DateTime date) async {
    final prices = InitialData.generatePrices(tokens: [token], dayHistoryCount: 30, startDate: date);
    for (final price in prices) {
      await _priceTokenDataProvider.saveData(price);
    }
    updateData();
    _streamController.add(PriceTokenRepositoryStreamEvents.addInitialPrices);
  }
}
