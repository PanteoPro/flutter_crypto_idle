import 'package:crypto_idle/domain/entities/token.dart';

import 'package:hive/hive.dart';

part 'statistics.g.dart';

@HiveType(typeId: 5)
class Statistics extends HiveObject {
  Statistics({
    required this.energyConsume,
    required this.flatConsume,
    required this.tokenEarn,
    required this.tokenMining,
  });
  Statistics.empty();

  @HiveField(0)
  List<double> energyConsume = [];
  @HiveField(1)
  List<double> flatConsume = [];
  @HiveField(2)
  Map<Token, List<double>> tokenEarn = {};
  @HiveField(3)
  Map<Token, List<double>> tokenMining = {};
}
