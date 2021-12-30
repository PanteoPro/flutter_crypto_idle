import 'package:hive/hive.dart';

part 'news.g.dart';

@HiveType(typeId: 6)
class News extends HiveObject {
  News({
    required this.text,
    required this.textENG,
    required this.newsTypeValue,
    this.tokenID,
    required this.date,
    this.isScamToken = false,
    this.isAllCrypto = false,
  });

  @HiveField(0)
  final String text;
  @HiveField(1)
  final int? tokenID;
  @HiveField(2)
  final int newsTypeValue;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  bool isActivate = false;
  @HiveField(5)
  bool isScamToken;
  @HiveField(6)
  bool isAllCrypto;
  @HiveField(7)
  final String textENG;
}
