import 'package:crypto_idle/domain/entities/token.dart';
import 'package:hive/hive.dart';

part 'pc.g.dart';

@HiveType(typeId: 1)
class PC {
  PC({
    required this.id,
    required this.name,
    required this.cost,
    required this.costSell,
    required this.power,
    required this.energy,
    this.miningToken,
  });

  PC.empty({
    this.id = -1,
    this.cost = 0,
    this.costSell = 0,
    this.power = 0,
    this.energy = 0,
    this.name = 'undefined',
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double cost;
  @HiveField(3)
  final double costSell;
  @HiveField(4)
  final double power;
  @HiveField(5)
  final double energy;
  @HiveField(6)
  Token? miningToken;

  PC copyWith({
    int? id,
    String? name,
    double? cost,
    double? costSell,
    double? power,
    double? energy,
    Token? miningToken,
  }) {
    return PC(
      id: id ?? this.id,
      name: name ?? this.name,
      cost: cost ?? this.cost,
      costSell: costSell ?? this.costSell,
      power: power ?? this.power,
      energy: energy ?? this.energy,
      miningToken: miningToken ?? this.miningToken,
    );
  }
}
