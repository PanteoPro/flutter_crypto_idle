import 'package:hive/hive.dart';

part 'game.g.dart';

@HiveType(typeId: 0)
class Game {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int money;
  @HiveField(2)
  final String nick;

  Game({required this.id, required this.money, required this.nick});
  Game.empty({this.id = -1, this.money = 0, this.nick = 'undefined'});

  Game copyWith({int? id, int? money, String? nick}) {
    return Game(id: id ?? this.id, money: money ?? this.money, nick: nick ?? this.nick);
  }
}
