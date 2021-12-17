import 'package:hive/hive.dart';

part 'statistics.g.dart';

@HiveType(typeId: 5)
class Statistics extends HiveObject {
  Statistics({
    required this.energyConsume,
    required this.flatConsume,
    required this.pcConsume,
    required this.tokenEarn,
    required this.tokenMining,
  });
  Statistics.empty();

  /// In $
  @HiveField(0)
  List<double> energyConsume = [];

  /// In $
  @HiveField(1)
  List<double> flatConsume = [];

  /// In $
  @HiveField(2)
  List<double> pcConsume = [];

  @HiveField(3)
  Map<int, List<double>> tokenEarn = {};
  @HiveField(4)
  Map<int, List<double>> tokenMining = {};
}
