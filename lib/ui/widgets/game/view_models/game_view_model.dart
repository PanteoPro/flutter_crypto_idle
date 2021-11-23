import 'package:crypto_idle/domain/entities/game.dart';
import 'package:crypto_idle/domain/repositories/game_repository.dart';
import 'package:flutter/cupertino.dart';

class GameViewModel extends ChangeNotifier {
  GameViewModel() {
    _initialRepository();
  }

  final _gameRepository = GameRepository();

  var _game = Game.empty();
  Game get game => _game;

  Future<void> _initialRepository() async {
    await _gameRepository.init();
    updateState();
  }

  /// Temp method for update balance in the appbar
  Future<void> tempMETHODLOAD() async {
    await _gameRepository.loadData();
    updateState();
  }

  void updateState() {
    _game = _gameRepository.game.copyWith();
    notifyListeners();
  }

  Future<void> changeMoney(double money) async {
    await _gameRepository.changeData(money: money);
    updateState();
  }
}
