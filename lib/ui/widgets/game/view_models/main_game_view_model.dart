import 'dart:async';
import 'package:collection/collection.dart';
import 'package:crypto_idle/domain/entities/token.dart';

import 'package:crypto_idle/domain/repositories/my_repository.dart';
import 'package:crypto_idle/domain/repositories/token_repository.dart';
import 'package:flutter/cupertino.dart';

import 'package:crypto_idle/domain/entities/statistics.dart';
import 'package:crypto_idle/domain/repositories/statistics_repository.dart';

class MainGameViewModelState {
  MainGameViewModelState({
    required this.statistics,
    required this.tokens,
  });
  MainGameViewModelState.empty({Statistics? statistics, List<Token>? tokens}) {
    this.statistics = statistics ?? Statistics.empty();
    this.tokens = tokens ?? [];
  }
  late Statistics statistics;
  late List<Token> tokens;

  double get sumFlatConsume => statistics.flatConsume.sum;
  double get sumEnergyConsume => statistics.energyConsume.sum;
  double get sumConsume => sumFlatConsume + sumEnergyConsume;

  double earnTokensByTokenId(int tokenId) {
    return statistics.tokenEarn[tokenId]?.sum ?? 0;
  }

  double miningTokensByTokenId(int tokenId) {
    return statistics.tokenMining[tokenId]?.sum ?? 0;
  }
}

class MainGameViewModel extends ChangeNotifier {
  MainGameViewModel() {
    _initialRepositories();
  }

  @override
  void dispose() {
    _statisticsStreamSub?.cancel();
    _tokensStreamSub?.cancel();
    super.dispose();
  }

  final _statisticsRepository = StatisticsRepository();
  final _tokensRepository = TokenRepository();
  StreamSubscription<dynamic>? _statisticsStreamSub;
  StreamSubscription<dynamic>? _tokensStreamSub;

  var _state = MainGameViewModelState.empty();
  MainGameViewModelState get state => _state;

  Future<void> _initialRepositories() async {
    await _statisticsRepository.init();
    await _tokensRepository.init();
    _subscriteStreams();
    await _updateState();
  }

  void _subscriteStreams() {
    _statisticsStreamSub =
        StatisticsRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _statisticsRepository));
    _tokensStreamSub =
        TokenRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _tokensRepository));
  }

  Future<void> _updateRepoByChangeEvent(dynamic data, MyRepository repository) async {
    await repository.updateData();
    if (repository is StatisticsRepository) {
      _updateState();
    }
  }

  Future<void> _updateState() async {
    _state = MainGameViewModelState(
      statistics: _statisticsRepository.statistics,
      tokens: _tokensRepository.tokens,
    );
    notifyListeners();
  }
}
