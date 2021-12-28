import 'dart:async';

import 'package:crypto_idle/domain/entities/statistics.dart';
import 'package:crypto_idle/domain/repositories/statistics_manager.dart';
import 'package:crypto_idle/domain/repositories/statistics_repository.dart';
import 'package:flutter/cupertino.dart';

class GameStatisticsViewModel extends ChangeNotifier {
  GameStatisticsViewModel() {
    _messageStreamSub = StatisticsManager.stream?.listen((event) {
      _updateState(event as StatisticsManagerStreamEvents);
    });
    initRepositories();
  }

  Future<void> initRepositories() async {
    await _statisticsRepository.init();
    statistics = _statisticsRepository.statistics;
    print(statistics.buyPCs);
    notifyListeners();
  }

  final _statisticsRepository = StatisticsRepository();
  var statistics = Statistics.empty();

  @override
  void dispose() {
    _messageStreamSub?.cancel();
    super.dispose();
  }

  void _updateState(StatisticsManagerStreamEvents event) {
    print(event);
    switch (event.state) {
      case StatisticsManagerStreamState.addBuyFlats:
        _statisticsRepository.addBuyFlats(event.value as double);
        break;
      case StatisticsManagerStreamState.addBuyPCs:
        _statisticsRepository.addBuyPCs(event.value as double);
        break;
      case StatisticsManagerStreamState.addDealsBuyVolume:
        _statisticsRepository.addDealsBuyVolume(event.value as double);
        break;
      case StatisticsManagerStreamState.addDealsSellVolume:
        _statisticsRepository.addDealsSellVolume(event.value as double);
        break;
      case StatisticsManagerStreamState.addEnergyConsume:
        _statisticsRepository.addEnergyConsume(event.value as double);
        break;
      case StatisticsManagerStreamState.addFlatConsume:
        _statisticsRepository.addFlatConsume(event.value as double);
        break;
      case StatisticsManagerStreamState.addTokenEarn:
        _statisticsRepository.addTokenEarn(event.token!, event.value as double);
        break;
      case StatisticsManagerStreamState.addTokenMining:
        _statisticsRepository.addTokenMining(event.token!, event.value as double);
        break;
    }
    statistics = _statisticsRepository.statistics;
    notifyListeners();
  }

  StreamSubscription<dynamic>? _messageStreamSub;
}
