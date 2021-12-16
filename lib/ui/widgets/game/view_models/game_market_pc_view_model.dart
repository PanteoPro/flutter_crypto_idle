import 'dart:async';

import 'package:crypto_idle/domain/entities/statistics.dart';
import 'package:crypto_idle/domain/repositories/flat_repository.dart';
import 'package:crypto_idle/domain/repositories/message_manager.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';
import 'package:crypto_idle/domain/repositories/statistics_repository.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_view_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:crypto_idle/domain/entities/pc.dart';
import 'package:crypto_idle/domain/repositories/game_repository.dart';
import 'package:crypto_idle/domain/repositories/pc_repository.dart';
import 'package:flutter/material.dart';

class GameMarketPCViewModelState {
  GameMarketPCViewModelState({
    required this.money,
    required this.marketPCs,
    required this.ownPCs,
  });
  GameMarketPCViewModelState.empty({
    this.money = 0,
    this.marketPCs = const <PC>[],
    this.ownPCs = const <PC>[],
  });

  final double money;
  final List<PC> ownPCs;
  final List<PC> marketPCs;

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

  GameMarketPCViewModelState copyWith({double? money, List<PC>? ownPCs, List<PC>? marketPCs}) {
    return GameMarketPCViewModelState(
        money: money ?? this.money, ownPCs: ownPCs ?? this.ownPCs, marketPCs: marketPCs ?? this.marketPCs);
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
  final _statisticsRepository = StatisticsRepository();
  StreamSubscription<dynamic>? _gameStreamSub;

  var _state = GameMarketPCViewModelState.empty();
  GameMarketPCViewModelState get state => _state;

  Future<void> _initialRepositories() async {
    await _pcRepository.init();
    await _gameRepository.init();
    await _flatRepository.init();
    await _statisticsRepository.init();
    _subscriteStreams();
    _updateState();
  }

  void _subscriteStreams() {
    _gameStreamSub = GameRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _gameRepository));
  }

  Future<void> _updateRepoByChangeEvent(dynamic data, MyRepository repository) async {
    repository.updateData();
  }

  Future<void> _updateState() async {
    _state = GameMarketPCViewModelState(
      money: _gameRepository.game.money,
      marketPCs: _pcRepository.pcsConst,
      ownPCs: _pcRepository.pcs,
    );
    notifyListeners();
  }

  Future<void> onBuyButtonPressed(int index) async {
    final pc = _state.marketPCs[index].copyWith();
    if (_state.money >= pc.cost) {
      final maxCountPC = _flatRepository.flats.firstWhere((element) => element.isActive).countPC;
      if (_state.ownPCs.length < maxCountPC) {
        await _pcRepository.addPC(pc);
        await _gameRepository.changeData(money: _state.money - pc.cost);
        await _statisticsRepository.addPCConsume(pc.cost);
        MessageManager.addMessage(text: 'Вы купили установку - ${pc.name} за ${pc.cost}\$', color: Colors.green);
      } else {
        MessageManager.addMessage(text: 'У вас максимальное количество установок!', color: Colors.red);
      }
    } else {
      MessageManager.addMessage(text: 'У вас недостаточно денег!', color: Colors.red);
    }
    _updateState();
  }

  Future<void> onSellButtonPressed(int index) async {
    final pc = _state.marketPCs[index];
    if (await _pcRepository.sellPC(pc)) {
      await _gameRepository.changeData(money: _state.money + pc.costSell);
      MessageManager.addMessage(text: 'Вы продали установку - ${pc.name} за ${pc.costSell}\$', color: Colors.green);
    } else {
      MessageManager.addMessage(text: 'Вы не можете продать, то чего у вас нет', color: Colors.red);
    }
    _updateState();
  }
}
