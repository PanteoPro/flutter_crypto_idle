import 'package:hive/hive.dart';

part 'game.g.dart';

@HiveType(typeId: 0)
class Game {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final double money;
  @HiveField(2)
  final String nick;
  @HiveField(3)
  final int maxCountPC;
  @HiveField(4)
  final int currentCountPC;

  Game({
    required this.id,
    required this.money,
    required this.nick,
    required this.maxCountPC,
    required this.currentCountPC,
  });
  Game.empty({
    this.id = -1,
    this.money = 0,
    this.nick = 'undefined',
    this.maxCountPC = 0,
    this.currentCountPC = 0,
  });

  Game copyWith({
    int? id,
    double? money,
    String? nick,
    int? maxCountPC,
    int? currentCountPC,
  }) {
    return Game(
      id: id ?? this.id,
      money: money ?? this.money,
      nick: nick ?? this.nick,
      maxCountPC: maxCountPC ?? this.maxCountPC,
      currentCountPC: currentCountPC ?? this.currentCountPC,
    );
  }
}
