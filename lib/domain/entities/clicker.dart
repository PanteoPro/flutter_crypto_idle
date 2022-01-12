import 'package:hive/hive.dart';

part 'clicker.g.dart';

@HiveType(typeId: 7)
class Clicker extends HiveObject {
  Clicker({
    required this.currentClicks,
    required this.maxClicks,
    required this.currentDelay,
    required this.maxDelay,
    required this.minMoney,
    required this.maxMoney,
    required this.critMoney,
    required this.probabilityCrit,
    required this.level,
    required this.maxLevel,
    required this.upgradeCost,
  });
  Clicker.start({
    this.currentClicks = 200,
    this.maxClicks = 200,
    this.currentDelay = 0,
    this.maxDelay = 60,
    this.minMoney = 0.01,
    this.maxMoney = 0.1,
    this.critMoney = 0.5,
    this.probabilityCrit = 0.05,
    this.level = 1,
    this.maxLevel = 50,
    this.upgradeCost = 7.75,
  });

  @HiveField(0)
  final int currentClicks;
  @HiveField(1)
  final int maxClicks;
  @HiveField(2)
  final int currentDelay;
  @HiveField(3)
  final int maxDelay;
  @HiveField(4)
  final double minMoney;
  @HiveField(5)
  final double maxMoney;
  @HiveField(6)
  final double critMoney;
  @HiveField(7)
  final double probabilityCrit;
  @HiveField(8)
  final int level;
  @HiveField(9)
  final int maxLevel;
  @HiveField(10)
  final double upgradeCost;

  Clicker copyWith({
    int? currentClicks,
    int? maxClicks,
    int? secondsDelay,
    int? maxDelay,
    double? minMoney,
    double? maxMoney,
    double? critMoney,
    double? probabilityCrit,
    int? level,
    int? maxLevel,
    double? upgradeCost,
  }) {
    return Clicker(
      currentClicks: currentClicks ?? this.currentClicks,
      maxClicks: maxClicks ?? this.maxClicks,
      currentDelay: secondsDelay ?? this.currentDelay,
      maxDelay: maxDelay ?? this.maxDelay,
      minMoney: minMoney ?? this.minMoney,
      maxMoney: maxMoney ?? this.maxMoney,
      critMoney: critMoney ?? this.critMoney,
      probabilityCrit: probabilityCrit ?? this.probabilityCrit,
      level: level ?? this.level,
      maxLevel: maxLevel ?? this.maxLevel,
      upgradeCost: upgradeCost ?? this.upgradeCost,
    );
  }
}
