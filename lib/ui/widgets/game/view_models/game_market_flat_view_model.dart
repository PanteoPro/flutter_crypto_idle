import 'package:crypto_idle/domain/entities/flat.dart';
import 'package:crypto_idle/domain/repositories/flat_repository.dart';
import 'package:crypto_idle/domain/repositories/game_repository.dart';
import 'package:crypto_idle/domain/repositories/pc_repository.dart';
import 'package:crypto_idle/domain/repositories/statistics_repository.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_view_model.dart';
import 'package:flutter/cupertino.dart';

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

  final _flatRepository = FlatRepository();
  final _pcRepository = PCRepository();
  final _gameRepository = GameRepository();
  final _statisticsRepository = StatisticsRepository();

  var _state = GameMarketFlatViewModelState.empty();
  GameMarketFlatViewModelState get state => _state;

  Future<void> initialRepositories() async {
    await _flatRepository.init();
    await _gameRepository.init();
    await _pcRepository.init();
    await _statisticsRepository.init();
    _updateState();
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
        await _flatRepository.changeFlat(flat, isBuy: true, isActive: true);
        await _flatRepository.changeFlat(currentFlat, isActive: false);

        await _gameRepository.changeData(money: _state.money - flat.cost);
        await _statisticsRepository.addFlatConsume(flat.cost);
      } else {
        // error message count PC
      }
    } else {
      // error message
    }
    _updateState();
  }

  Future<void> onActivateButtonPressed(int index) async {
    final flat = _state.flats[index];
    final currentFlat = _state.currentFlat();
    if (!flat.isActive && flat.isBuy) {
      final currentCountPC = _pcRepository.pcs.length;
      if (currentCountPC <= flat.countPC) {
        await _flatRepository.changeFlat(currentFlat, isActive: false);
        await _flatRepository.changeFlat(flat, isActive: true);
      } else {
        // error message count pc
      }
    } else {
      // error message
    }
    _updateState();
  }
}
