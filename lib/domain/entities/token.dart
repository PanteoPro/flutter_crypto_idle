import 'package:crypto_idle/domain/entities/price_token.dart';
import 'package:hive/hive.dart';

part 'token.g.dart';

@HiveType(typeId: 3)
class Token extends HiveObject {
  Token({
    required this.id,
    required this.symbol,
    required this.fullName,
    required this.count,
    required this.isScam,
  });
  Token.empty({
    this.id = -1,
    this.symbol = 'NONE',
    this.fullName = 'undefined',
    this.count = 0,
    this.isScam = false,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String symbol;
  @HiveField(2)
  final String fullName;
  @HiveField(3)
  double count;
  @HiveField(4)
  bool isScam;
}
