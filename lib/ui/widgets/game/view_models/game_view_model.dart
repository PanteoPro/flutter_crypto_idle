import 'package:crypto_idle/domain/entities/game.dart';
import 'package:crypto_idle/domain/repositories/flat_repository.dart';
import 'package:crypto_idle/domain/repositories/game_repository.dart';
import 'package:crypto_idle/domain/repositories/pc_repository.dart';
import 'package:flutter/cupertino.dart';

class GameViewModel extends ChangeNotifier {
  GameViewModel() {
    _initialRepository();
  }

  final _gameRepository = GameRepository();
  final _pcRepository = PCRepository();
  final _flatRepository = FlatRepository();

  var _game = Game.empty();
  Game get game => _game;

  int get currentCountPC => _pcRepository.pcs.length;
  int get maxCountPC => _flatRepository.flats.firstWhere((element) => element.isActive).countPC;

  Future<void> _initialRepository() async {
    await _gameRepository.init();
    await _pcRepository.init();
    await _flatRepository.init();
    updateState();
  }

  /// Temp method for update balance in the appbar
  Future<void> TEMP_UPDAGE_DATA() async {
    await _gameRepository.init();
    await _pcRepository.init();
    await _flatRepository.init();
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
