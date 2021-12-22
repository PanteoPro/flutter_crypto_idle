import 'package:hive/hive.dart';

part 'flat.g.dart';

@HiveType(typeId: 2)
class Flat extends HiveObject {
  Flat({
    required this.id,
    required this.name,
    required this.cost,
    required this.costMonth,
    required this.countPC,
    required this.isBuy,
    required this.isActive,
    required this.level,
  });
  Flat.empty({
    this.id = -1,
    this.name = 'undefined',
    this.cost = 0,
    this.costMonth = 0,
    this.countPC = 0,
    this.isBuy = false,
    this.isActive = false,
    this.level = 0,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double cost;
  @HiveField(3)
  final double costMonth;
  @HiveField(4)
  final int countPC;
  @HiveField(5)
  bool isBuy;
  @HiveField(6)
  bool isActive;
  @HiveField(7)
  final int level;

  Flat copyWith({
    int? id,
    String? name,
    double? cost,
    double? costMonth,
    int? countPC,
    bool? isBuy,
    bool? isActive,
    int? level,
  }) {
    return Flat(
      id: id ?? this.id,
      name: name ?? this.name,
      cost: cost ?? this.cost,
      costMonth: costMonth ?? this.costMonth,
      countPC: countPC ?? this.countPC,
      isBuy: isBuy ?? this.isBuy,
      isActive: isActive ?? this.isActive,
      level: level ?? this.level,
    );
  }
}
