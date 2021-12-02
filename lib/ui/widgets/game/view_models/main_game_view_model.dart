import 'dart:async';

import 'package:crypto_idle/domain/repositories/my_repository.dart';
import 'package:flutter/cupertino.dart';

import 'package:crypto_idle/domain/entities/statistics.dart';
import 'package:crypto_idle/domain/repositories/statistics_repository.dart';

class MainGameViewModelState {
  MainGameViewModelState({
    required this.statistics,
  });
  MainGameViewModelState.empty({Statistics? statistics}) {
    this.statistics = statistics ?? Statistics.empty();
  }
  late Statistics statistics;
}

class MainGameViewModel extends ChangeNotifier {
  MainGameViewModel() {
    _initialRepositories();
  }

  @override
  void dispose() {
    _statisticsStreamSub?.cancel();
    super.dispose();
  }

  final _statisticsRepository = StatisticsRepository();
  StreamSubscription<dynamic>? _statisticsStreamSub;

  var _state = MainGameViewModelState.empty();
  MainGameViewModelState get state => _state;

  Future<void> _initialRepositories() async {
    await _statisticsRepository.init();
    _subscriteStreams();
    await _updateState();
  }

  void _subscriteStreams() {
    _statisticsStreamSub =
        StatisticsRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _statisticsRepository));
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
    );
    notifyListeners();
  }
}
