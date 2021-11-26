import 'dart:async';

import 'package:crypto_idle/domain/entities/game.dart';
import 'package:crypto_idle/domain/repositories/flat_repository.dart';
import 'package:crypto_idle/domain/repositories/game_repository.dart';
import 'package:crypto_idle/domain/repositories/pc_repository.dart';
import 'package:crypto_idle/domain/repositories/token_repository.dart';
import 'package:flutter/cupertino.dart';

class GameViewModel extends ChangeNotifier {
  GameViewModel() {
    _initialRepository();
    dayStream = Stream.periodic(const Duration(seconds: lengthDaySeconds), (int day) {
      return day;
    });
    dayStream.listen(_newDay);

    _dayEndController = StreamController<dynamic>();
    dayEndStream = _dayEndController.stream.asBroadcastStream();
  }

  @override
  void dispose() {
    _dayEndController.close();
    super.dispose();
  }

  static const lengthDaySeconds = 10;

  late Stream<dynamic> dayStream;

  late StreamController<dynamic> _dayEndController;
  late Stream<dynamic> dayEndStream;

  final _gameRepository = GameRepository();
  final _pcRepository = PCRepository();
  final _flatRepository = FlatRepository();
  final _tokenRepository = TokenRepository();

  var _game = Game.empty(date: DateTime(0));
  Game get game => _game;

  int get currentCountPC => _pcRepository.pcs.length;
  int get maxCountPC => _flatRepository.flats.firstWhere((element) => element.isActive).countPC;

  Future<void> _initialRepository() async {
    await _gameRepository.init();
    await _pcRepository.init();
    await _flatRepository.init();
    await _tokenRepository.init();
    updateState();
  }

  /// Temp method for update balance in the appbar
  Future<void> TEMP_UPDAGE_DATA() async {
    await _gameRepository.init();
    await _pcRepository.init();
    await _flatRepository.init();
    await _tokenRepository.init();
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

  Future<void> _newDay(dynamic numberDaySession) async {
    print('day $numberDaySession');
    TEMP_UPDAGE_DATA();

    await _gameRepository.changeData(date: _game.date.add(Duration(days: 1)));
    await _miningDay();
    _dayEndController.add(numberDaySession);
    updateState();
  }

  Future<void> _miningDay() async {
    final ownPC = _pcRepository.pcs;
    final tokens = _tokenRepository.tokens;
    for (final pc in ownPC) {
      if (pc.miningToken != null) {
        final powerMining = pc.power;

        final token = tokens.firstWhere((element) => element.id == pc.miningToken!.id);
        final coefMining = token.coefMining;
        final countMined = powerMining * coefMining;

        await _tokenRepository.changeToken(token, count: token.count + countMined);
        print('+ ${countMined.toStringAsFixed(8)} ${token.symbol}');
      }
    }
  }
}
