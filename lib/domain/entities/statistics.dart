import 'package:hive/hive.dart';

part 'statistics.g.dart';

@HiveType(typeId: 5)
class Statistics extends HiveObject {
  Statistics({
    required this.buyPCs,
    required this.buyFlats,
    required this.energyConsume,
    required this.flatConsume,
    required this.dealsBuyVolume,
    required this.dealsSellVolume,
    required this.tokenEarn,
    required this.tokenMining,
    required this.clickerEarn,
  });
  Statistics.empty();

  /// In $
  @HiveField(0)
  List<double> buyPCs = [];

  /// In $
  @HiveField(1)
  List<double> buyFlats = [];

  /// In $
  @HiveField(2)
  List<double> energyConsume = [];

  /// In $
  @HiveField(3)
  List<double> flatConsume = [];

  /// In $
  @HiveField(4)
  List<double> dealsBuyVolume = [];

  /// In $
  @HiveField(5)
  List<double> dealsSellVolume = [];

  @HiveField(6)
  Map<int, List<double>> tokenEarn = {};
  @HiveField(7)
  Map<int, List<double>> tokenMining = {};
  @HiveField(8)
  int clickedPC = 0;
  @HiveField(9)
  List<double> clickerEarn = [];
  @HiveField(10)
  int clickedPCCrits = 0;
  @HiveField(11)
  int countDays = 0;
}
