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

  const Game({
    required this.id,
    required this.money,
    required this.nick,
    required this.date,
    this.gameOver = false,
  });
  const Game.empty({
    this.id = -1,
    this.money = 0,
    this.nick = 'undefined',
    required this.date,
    this.gameOver = false,
  });

  Game copyWith({
    int? id,
    double? money,
    String? nick,
    DateTime? date,
    bool? gameOver,
  }) {
    return Game(
      id: id ?? this.id,
      money: money ?? this.money,
      nick: nick ?? this.nick,
      date: date ?? this.date,
      gameOver: gameOver ?? this.gameOver,
    );
  }
}
