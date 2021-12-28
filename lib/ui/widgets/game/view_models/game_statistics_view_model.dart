import 'package:crypto_idle/domain/repositories/statistics_repository.dart';
import 'package:flutter/cupertino.dart';

class GameStatisticsViewModel extends ChangeNotifier {
  final _statisticsRepository = StatisticsRepository();
}
