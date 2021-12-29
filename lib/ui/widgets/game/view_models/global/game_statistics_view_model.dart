import 'dart:async';

import 'package:crypto_idle/domain/entities/statistics.dart';
import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';
import 'package:crypto_idle/domain/repositories/statistics_manager.dart';
import 'package:crypto_idle/domain/repositories/statistics_repository.dart';
import 'package:crypto_idle/domain/repositories/token_repository.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class GameStatisticsViewModelState {
  GameStatisticsViewModelState({
    required this.statistics,
    required this.tokens,
  });
  GameStatisticsViewModelState.empty({
    this.tokens = const [],
  }) {
    statistics = Statistics.empty();
  }

  late Statistics statistics;
  late List<Token> tokens;

  // for context.select
  String get energyConsume => statistics.energyConsume.sum.toStringAsFixed(2);
  String get flatConsume => statistics.flatConsume.sum.toStringAsFixed(2);
  String get daysCount => statistics.countDays.toString();
  Map<int, List<double>> get tokenEarn => statistics.tokenEarn;
  Map<int, List<double>> get tokenMining => statistics.tokenMining;

  Token tokenById(int id) => tokens.firstWhere((element) => element.id == id);
}

class GameStatisticsViewModel extends ChangeNotifier {
  GameStatisticsViewModel() {
    _messageStreamSub = StatisticsManager.stream?.listen((event) {
      _updateState(event as StatisticsManagerStreamEvents);
    });
    initRepositories();
  }

  Future<void> initRepositories() async {
    await _statisticsRepository.init();
    await _tokensRepository.init();
    print('Tokens Init');
    _tokenStreamSub =
        TokenRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _tokensRepository));
    _updateState();
  }

  Future<void> _updateRepoByChangeEvent(dynamic data, MyRepository repository) async {
    repository.updateData();
    _updateState();
  }

  final _statisticsRepository = StatisticsRepository();

  final _tokensRepository = TokenRepository();
  StreamSubscription<dynamic>? _tokenStreamSub;

  var state = GameStatisticsViewModelState.empty();

  @override
  void dispose() {
    _tokenStreamSub?.cancel();
    _messageStreamSub?.cancel();
    super.dispose();
  }

  Future<void> _updateState([StatisticsManagerStreamEvents? event]) async {
    if (event != null) {
      switch (event.state) {
        case StatisticsManagerStreamState.addBuyFlats:
          await _statisticsRepository.addBuyFlats(event.value as double);
          break;
        case StatisticsManagerStreamState.addBuyPCs:
          await _statisticsRepository.addBuyPCs(event.value as double);
          break;
        case StatisticsManagerStreamState.addDealsBuyVolume:
          await _statisticsRepository.addDealsBuyVolume(event.value as double);
          break;
        case StatisticsManagerStreamState.addDealsSellVolume:
          await _statisticsRepository.addDealsSellVolume(event.value as double);
          break;
        case StatisticsManagerStreamState.addEnergyConsume:
          await _statisticsRepository.addEnergyConsume(event.value as double);
          break;
        case StatisticsManagerStreamState.addFlatConsume:
          await _statisticsRepository.addFlatConsume(event.value as double);
          break;
        case StatisticsManagerStreamState.addTokenEarn:
          await _statisticsRepository.addTokenEarn(event.token!, event.value as double);
          break;
        case StatisticsManagerStreamState.addTokenMining:
          await _statisticsRepository.addTokenMining(event.token!, event.value as double);
          break;
        case StatisticsManagerStreamState.addClickerPc:
          await _statisticsRepository.addClickerPc();
          break;
        case StatisticsManagerStreamState.addClickerEarn:
          await _statisticsRepository.addClickerEarn(event.value as double);
          break;
        case StatisticsManagerStreamState.addClickerCrit:
          await _statisticsRepository.addClickerCrit();
          break;
        case StatisticsManagerStreamState.addDays:
          await _statisticsRepository.addDays();
          break;
      }
    }
    state = GameStatisticsViewModelState(
      statistics: _statisticsRepository.statistics,
      tokens: _tokensRepository.tokens,
    );
    notifyListeners();
  }

  StreamSubscription<dynamic>? _messageStreamSub;
}
