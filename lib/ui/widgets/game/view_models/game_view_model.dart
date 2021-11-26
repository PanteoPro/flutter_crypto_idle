import 'dart:async';

import 'package:crypto_idle/domain/entities/game.dart';
import 'package:crypto_idle/domain/repositories/flat_repository.dart';
import 'package:crypto_idle/domain/repositories/game_repository.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';
import 'package:crypto_idle/domain/repositories/pc_repository.dart';
import 'package:crypto_idle/domain/repositories/token_repository.dart';
import 'package:flutter/cupertino.dart';

class GameViewModel extends ChangeNotifier {
  GameViewModel() {
    _initialRepository();
    _initialDayStream();
  }

  @override
  void dispose() {
    _gameStreamSub?.cancel();
    _pcStreamSub?.cancel();
    _flatStreamSub?.cancel();
    _tokenStreamSub?.cancel();
    super.dispose();
  }

  // Day Stream
  static const lengthDaySeconds = 10;
  late Stream<dynamic> dayStream;

  void _initialDayStream() {
    dayStream = Stream.periodic(const Duration(seconds: lengthDaySeconds), (int day) {
      return day;
    });
    dayStream.listen(_newDay);
  }

  // Repositories
  final _gameRepository = GameRepository();
  final _pcRepository = PCRepository();
  final _flatRepository = FlatRepository();
  final _tokenRepository = TokenRepository();
  StreamSubscription<dynamic>? _gameStreamSub;
  StreamSubscription<dynamic>? _pcStreamSub;
  StreamSubscription<dynamic>? _flatStreamSub;
  StreamSubscription<dynamic>? _tokenStreamSub;

  // Data
  var _game = Game.empty(date: DateTime(0));
  Game get game => _game;
  // Methods need move TO STATE _______________________________________________________
  int get currentCountPC => _pcRepository.pcs.length;
  int get maxCountPC => _flatRepository.flats.firstWhere((element) => element.isActive).countPC;

  /// Initial Repository
  Future<void> _initialRepository() async {
    await _gameRepository.init();
    await _pcRepository.init();
    await _flatRepository.init();
    await _tokenRepository.init();
    _subscriteStreams();
    updateState();
  }

  /// Subscribes to Repositories streams
  void _subscriteStreams() {
    _gameStreamSub = GameRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _gameRepository));
    _pcStreamSub = PCRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _pcRepository));
    _flatStreamSub = FlatRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _flatRepository));
    _tokenStreamSub =
        TokenRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _tokenRepository));
  }

  Future<void> _updateRepoByChangeEvent(dynamic data, MyRepository repository) async {
    await repository.updateData();
    if (repository is GameRepository) {
      updateState();
    }
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
    await _gameRepository.changeData(date: _game.date.add(Duration(days: 1)));
    await _miningDay();
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
