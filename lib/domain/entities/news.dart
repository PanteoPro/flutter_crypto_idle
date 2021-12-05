import 'package:crypto_idle/domain/repositories/news_repository.dart';
import 'package:hive/hive.dart';

part 'news.g.dart';

@HiveType(typeId: 6)
class News extends HiveObject {
  News({required this.text, required this.newsTypeValue, required this.symbol, required this.date});

  @HiveField(0)
  final String text;
  @HiveField(1)
  final int newsTypeValue;
  @HiveField(2)
  final String symbol;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  bool isActivate = false;
}
