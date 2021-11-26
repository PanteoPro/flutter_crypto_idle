import 'package:hive/hive.dart';

part 'price_token.g.dart';

@HiveType(typeId: 4)
class PriceToken extends HiveObject {
  PriceToken({required this.date, required this.cost, required this.tokenId});
  PriceToken.empty({DateTime? date, this.cost = 0, this.tokenId = -1}) : date = date ?? DateTime(0);

  @HiveField(0)
  DateTime date;
  @HiveField(1)
  final double cost;
  @HiveField(2)
  final int tokenId;

  PriceToken copyWith({
    DateTime? date,
    double? cost,
    int? tokenId,
  }) {
    return PriceToken(
      date: date ?? this.date,
      cost: cost ?? this.cost,
      tokenId: tokenId ?? this.tokenId,
    );
  }
}
