import 'dart:async';

import 'package:crypto_tycoon/Theme/app_colors.dart';
import 'package:crypto_tycoon/config.dart';
import 'package:crypto_tycoon/domain/entities/statistics.dart';
import 'package:crypto_tycoon/domain/repositories/flat_repository.dart';
import 'package:crypto_tycoon/domain/repositories/message_manager.dart';
import 'package:crypto_tycoon/domain/repositories/music_manager.dart';
import 'package:crypto_tycoon/domain/repositories/my_repository.dart';
import 'package:crypto_tycoon/domain/repositories/statistics_manager.dart';
import 'package:crypto_tycoon/domain/repositories/statistics_repository.dart';
import 'package:crypto_tycoon/ui/widgets/game/view_models/global/game_view_model.dart';
import 'package:crypto_tycoon/ui/widgets/music_view_model.dart';

import 'package:crypto_tycoon/domain/entities/pc.dart';
import 'package:crypto_tycoon/domain/repositories/game_repository.dart';
import 'package:crypto_tycoon/domain/repositories/pc_repository.dart';
import 'package:flutter/material.dart';

class GameMarketPCViewModelState {
  GameMarketPCViewModelState({
    required this.date,
    required this.money,
    required this.marketPCs,
    required this.ownPCs,
    required this.currentLevel,
    required this.maxPCs,
  });
  GameMarketPCViewModelState.empty({
    this.money = 0,
    this.marketPCs = const <PC>[],
    this.ownPCs = const <PC>[],
    this.currentLevel = 0,
    this.maxPCs = 0,
  }) {
    date = DateTime(0);
  }

  late DateTime date;
  final double money;
  final List<PC> ownPCs;
  final List<PC> marketPCs;
  final int currentLevel;
  final int maxPCs;

  /// energy cost if date > 5 day in start month
  double ifEnergyCostByPc(PC pc) {
    double result = 0;
    final monthAfterPay = date.add(Duration(days: -date.day + 5));
    if (date.isAfter(monthAfterPay)) {
      result = pc.energy / AppConfig.kVisualEnergy * AppConfig.kEnergyPc;
    }
    return result;
  }

  double _energyCostByPc(PC pc) => pc.energy / AppConfig.kVisualEnergy * AppConfig.kEnergyPc;

  bool haveSpaceForNewPC() {
    return ownPCs.length < maxPCs;
  }

  bool enoughtLevelByPC(PC pc) {
    return currentLevel >= pc.needLevel;
  }

  int getCountPCsById(int id) {
    int count = 0;
    ownPCs.forEach((PC pc) {
      if (pc.id == id) {
        count += 1;
      }
    });
    return count;
  }

  bool isHavePCById(int id) {
    return ownPCs.any((PC pc) => pc.id == id);
  }

  GameMarketPCViewModelState copyWith({
    double? money,
    List<PC>? ownPCs,
    List<PC>? marketPCs,
    int? currentLevel,
    int? maxPCs,
    DateTime? date,
  }) {
    return GameMarketPCViewModelState(
      date: date ?? this.date,
      money: money ?? this.money,
      ownPCs: ownPCs ?? this.ownPCs,
      marketPCs: marketPCs ?? this.marketPCs,
      currentLevel: currentLevel ?? this.currentLevel,
      maxPCs: maxPCs ?? this.maxPCs,
    );
  }
}

class GameMarketPCViewModel extends ChangeNotifier {
  GameMarketPCViewModel() {
    _initialRepositories();
  }
  @override
  void dispose() {
    _gameStreamSub?.cancel();
    super.dispose();
  }

  final _pcRepository = PCRepository();
  final _flatRepository = FlatRepository();
  final _gameRepository = GameRepository();
  StreamSubscription<dynamic>? _gameStreamSub;

  var _state = GameMarketPCViewModelState.empty();
  GameMarketPCViewModelState get state => _state;

  Future<void> _initialRepositories() async {
    await _pcRepository.init();
    await _gameRepository.init();
    await _flatRepository.init();
    _subscriteStreams();
    _updateState();
  }

  void _subscriteStreams() {
    _gameStreamSub = GameRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _gameRepository));
  }

  Future<void> _updateRepoByChangeEvent(dynamic data, MyRepository repository) async {
    repository.updateData();
    _updateState();
  }

  Future<void> _updateState() async {
    _state = GameMarketPCViewModelState(
      date: _gameRepository.game.date,
      money: _gameRepository.game.money,
      marketPCs: _pcRepository.pcsConst,
      ownPCs: _pcRepository.pcs,
      currentLevel: _flatRepository.currentFlat.level,
      maxPCs: _flatRepository.currentFlat.countPC,
    );
    notifyListeners();
  }

  Future<void> onBuyButtonPressed(int index) async {
    final pc = _state.marketPCs[index].copyWith();
    if (_state.currentLevel >= pc.needLevel) {
      if (_state.money >= pc.cost) {
        final maxCountPC = _flatRepository.flats.firstWhere((element) => element.isActive).countPC;
        if (_state.ownPCs.length < maxCountPC) {
          MusicManager.playBuy();
          await _gameRepository.changeMoney(-pc.cost);
          await _pcRepository.addPC(pc);
          StatisticsManager.sendMessageStream(
            StatisticsManagerStreamEvents(
              state: StatisticsManagerStreamState.addBuyPCs,
              value: pc.cost,
            ),
          );
          MessageManager.addMessage(AppMessage.buyPC(name: pc.name, cost: pc.cost));
        } else {
          MessageManager.addMessage(AppMessage.errorPCMaxPC());
        }
      } else {
        MessageManager.addMessage(AppMessage.errorPCNotEnoughtMoney());
      }
    } else {
      MessageManager.addMessage(AppMessage.errorPCNotEnoughtLevel());
    }
    _updateState();
  }

  Future<void> onSellButtonPressed(int index) async {
    final pc = _state.marketPCs[index];
    if (await _pcRepository.sellPC(pc)) {
      MusicManager.playSell();
      final energyConsume = state.ifEnergyCostByPc(pc);
      final finalEarnings = pc.costSell - energyConsume;
      await _gameRepository.changeMoney(finalEarnings);
      MessageManager.addMessage(AppMessage.sellPC(name: pc.name, cost: pc.costSell));
      if (energyConsume > 0) {
        StatisticsManager.sendMessageStream(
          StatisticsManagerStreamEvents(
            state: StatisticsManagerStreamState.addEnergyConsume,
            value: energyConsume,
          ),
        );
      }
    } else {
      MessageManager.addMessage(AppMessage.errorSellPCNothing());
    }
    _updateState();
  }
}
