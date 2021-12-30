import 'dart:async';

import 'package:crypto_idle/Theme/app_colors.dart';
import 'package:crypto_idle/domain/entities/flat.dart';
import 'package:crypto_idle/domain/repositories/flat_repository.dart';
import 'package:crypto_idle/domain/repositories/game_repository.dart';
import 'package:crypto_idle/domain/repositories/message_manager.dart';
import 'package:crypto_idle/domain/repositories/music_manager.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';
import 'package:crypto_idle/domain/repositories/pc_repository.dart';
import 'package:crypto_idle/domain/repositories/statistics_manager.dart';
import 'package:crypto_idle/domain/repositories/statistics_repository.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/global/game_view_model.dart';
import 'package:flutter/material.dart';

class GameMarketFlatViewModelState {
  GameMarketFlatViewModelState({required this.money, required this.flats});
  GameMarketFlatViewModelState.empty({this.money = 0, this.flats = const []});

  final double money;
  final List<Flat> flats;

  Flat currentFlat() {
    return flats.firstWhere((Flat flat) => flat.isActive);
  }

  GameMarketFlatViewModelState copyWith({
    double? money,
    List<Flat>? flats,
  }) {
    return GameMarketFlatViewModelState(
      money: money ?? this.money,
      flats: flats ?? this.flats,
    );
  }
}

class GameMarketFlatViewModel extends ChangeNotifier {
  GameMarketFlatViewModel() {
    initialRepositories();
  }

  @override
  void dispose() {
    _gameStreamSub?.cancel();
    super.dispose();
  }

  final _flatRepository = FlatRepository();
  final _pcRepository = PCRepository();
  final _gameRepository = GameRepository();
  StreamSubscription<dynamic>? _gameStreamSub;

  var _state = GameMarketFlatViewModelState.empty();
  GameMarketFlatViewModelState get state => _state;

  Future<void> initialRepositories() async {
    await _flatRepository.init();
    await _gameRepository.init();
    await _pcRepository.init();
    _subscriteStreams();
    _updateState();
  }

  void _subscriteStreams() {
    _gameStreamSub = GameRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _gameRepository));
  }

  Future<void> _updateRepoByChangeEvent(dynamic data, MyRepository repository) async {
    repository.updateData();
  }

  void _updateState() {
    _state = GameMarketFlatViewModelState(
      money: _gameRepository.game.money,
      flats: _flatRepository.flats,
    );
    notifyListeners();
  }

  Future<void> onBuyButtonPressed(int index) async {
    final flat = _state.flats[index];
    final currentFlat = _state.currentFlat();

    if (_state.money >= flat.cost) {
      final currentCountPC = _pcRepository.pcs.length;
      if (currentCountPC <= flat.countPC) {
        MusicManager.playBuy();
        await _flatRepository.changeFlat(flat, isBuy: true, isActive: true);
        await _flatRepository.changeFlat(currentFlat, isActive: false);

        await _gameRepository.changeMoney(-flat.cost);
        StatisticsManager.sendMessageStream(
          StatisticsManagerStreamEvents(
            state: StatisticsManagerStreamState.addBuyFlats,
            value: flat.cost,
          ),
        );
        MessageManager.addMessage(AppMessage.buyFlat(flatName: flat.name, cost: flat.cost));
      } else {
        MessageManager.addMessage(AppMessage.errorFlatWithMaxPC());
      }
    } else {
      MessageManager.addMessage(AppMessage.errorFlatNotEnoughtMoney());
    }
    _updateState();
  }

  int _getMaxLevelPc() {
    final pcs = _pcRepository.pcs;
    int level = 1;
    for (final pc in pcs) {
      if (pc.needLevel > level) {
        level = pc.needLevel;
      }
    }
    return level;
  }

  Future<void> onActivateButtonPressed(int index) async {
    final flat = _state.flats[index];
    final currentFlat = _state.currentFlat();
    if (!flat.isActive && flat.isBuy) {
      final currentCountPC = _pcRepository.pcs.length;
      if (currentCountPC <= flat.countPC) {
        if (_getMaxLevelPc() <= flat.level) {
          await _flatRepository.changeFlat(currentFlat, isActive: false);
          await _flatRepository.changeFlat(flat, isActive: true);
          MessageManager.addMessage(AppMessage.changeFlat(flatName: flat.name));
        } else {
          MessageManager.addMessage(AppMessage.errorNotEnoughLevelFlat(flatName: flat.name));
        }
      } else {
        MessageManager.addMessage(AppMessage.errorFlatWithMaxPC());
      }
    } else {
      MessageManager.addMessage(AppMessage.errorFlatNotBoughtFlat());
    }
    _updateState();
  }
}
