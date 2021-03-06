import 'package:hive/hive.dart';

part 'token.g.dart';

@HiveType(typeId: 3)
class Token extends HiveObject {
  Token({
    required this.id,
    required this.symbol,
    required this.fullName,
    required this.count,
    required this.isScam,
    required this.dateCreated,
  });
  Token.empty({
    this.id = -1,
    this.symbol = 'NONE',
    this.fullName = 'undefined',
    this.count = 0,
    this.isScam = false,
  }) {
    dateCreated = DateTime(0);
  }

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String symbol;
  @HiveField(2)
  final String fullName;
  @HiveField(3)
  double count;
  @HiveField(4)
  bool isScam;
  @HiveField(5)
  late DateTime dateCreated;
}
