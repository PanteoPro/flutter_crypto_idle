import 'dart:async';

import 'package:crypto_idle/domain/repositories/flat_repository.dart';
import 'package:crypto_idle/domain/repositories/game_repository.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';
import 'package:crypto_idle/domain/repositories/pc_repository.dart';
import 'package:flutter/cupertino.dart';

class GameViewModelState {
  GameViewModelState({
    required this.date,
    required this.money,
    required this.currentCountPC,
    required this.maxCountPC,
  });
  GameViewModelState.empty({
    this.money = 0,
    this.currentCountPC = 0,
    this.maxCountPC = 0,
  }) {
    date = DateTime(0);
  }
  late DateTime date;
  final double money;
  final int currentCountPC;
  final int maxCountPC;
}

class GameViewModel extends ChangeNotifier {
  GameViewModel() {
    _initialRepository();
  }

  @override
  void dispose() {
    _gameStreamSub?.cancel();
    _pcStreamSub?.cancel();
    _flatStreamSub?.cancel();
    super.dispose();
  }

  // Repositories
  final _gameRepository = GameRepository();
  final _pcRepository = PCRepository();
  final _flatRepository = FlatRepository();

  StreamSubscription<dynamic>? _gameStreamSub;
  StreamSubscription<dynamic>? _pcStreamSub;
  StreamSubscription<dynamic>? _flatStreamSub;

  // Data
  var _state = GameViewModelState.empty();
  GameViewModelState get state => _state;

  /// Initial Repository
  Future<void> _initialRepository() async {
    await _gameRepository.init();
    await _pcRepository.init();
    await _flatRepository.init();
    _subscriteStreams();
    updateState();
  }

  /// Subscribes to Repositories streams
  void _subscriteStreams() {
    _gameStreamSub = GameRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _gameRepository));
    _pcStreamSub = PCRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _pcRepository));
    _flatStreamSub = FlatRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _flatRepository));
  }

  Future<void> _updateRepoByChangeEvent(dynamic data, MyRepository repository) async {
    repository.updateData();
    updateState();
  }

  void updateState() {
    _state = GameViewModelState(
      date: _gameRepository.game.date,
      money: _gameRepository.game.money,
      maxCountPC: _flatRepository.flats.firstWhere((element) => element.isActive).countPC,
      currentCountPC: _pcRepository.pcs.length,
    );
    notifyListeners();
  }
}
