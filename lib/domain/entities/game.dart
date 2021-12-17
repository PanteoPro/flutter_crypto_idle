import 'package:hive/hive.dart';

part 'game.g.dart';

@HiveType(typeId: 0)
class Game {
  // 3 4 fbeld was user
  @HiveField(0)
  final int id;
  @HiveField(1)
  final double money;
  @HiveField(2)
  final String nick;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final bool gameOver;
  @HiveField(5)
  final int currentClicks;
  @HiveField(6)
  final int secondsDelay;
  static const maxClicks = 20;
  static const maxDelay = 10;

  const Game({
    required this.id,
    required this.money,
    required this.nick,
    required this.date,
    required this.currentClicks,
    required this.secondsDelay,
    this.gameOver = false,
  });
  const Game.empty({
    this.id = -1,
    this.money = 0,
    this.nick = 'undefined',
    required this.date,
    this.gameOver = false,
    this.currentClicks = maxClicks,
    this.secondsDelay = 0,
  });

  Game copyWith({
    int? id,
    double? money,
    String? nick,
    DateTime? date,
    bool? gameOver,
    int? currentClicks,
    int? secondsDelay,
  }) {
    return Game(
      id: id ?? this.id,
      money: money ?? this.money,
      nick: nick ?? this.nick,
      date: date ?? this.date,
      gameOver: gameOver ?? this.gameOver,
      currentClicks: currentClicks ?? this.currentClicks,
      secondsDelay: secondsDelay ?? this.secondsDelay,
    );
  }
}
