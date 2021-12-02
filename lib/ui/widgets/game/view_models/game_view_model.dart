import 'dart:async';
import 'dart:math';

import 'package:crypto_idle/domain/entities/game.dart';
import 'package:crypto_idle/domain/entities/price_token.dart';
import 'package:crypto_idle/domain/repositories/flat_repository.dart';
import 'package:crypto_idle/domain/repositories/game_repository.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';
import 'package:crypto_idle/domain/repositories/pc_repository.dart';
import 'package:crypto_idle/domain/repositories/price_token_repository.dart';
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
    _priceTokenStreamSub?.cancel();
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
  final _priceTokenRepository = PriceTokenRepository();
  StreamSubscription<dynamic>? _gameStreamSub;
  StreamSubscription<dynamic>? _pcStreamSub;
  StreamSubscription<dynamic>? _flatStreamSub;
  StreamSubscription<dynamic>? _tokenStreamSub;
  StreamSubscription<dynamic>? _priceTokenStreamSub;

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
    await _priceTokenRepository.init();
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
    _priceTokenStreamSub =
        TokenRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _priceTokenRepository));
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

  // New day logic

  Future<void> _newDay(dynamic numberDaySession) async {
    print('day $numberDaySession');
    await _gameRepository.changeData(date: _game.date.add(Duration(days: 1)));
    await _miningDay();
    await _newPricesDay();
  }

  Future<void> _miningDay() async {
    final ownPC = _pcRepository.pcs;
    final tokens = _tokenRepository.tokens;
    for (final pc in ownPC) {
      if (pc.miningToken != null) {
        final powerMining = pc.power;

        final token = tokens.firstWhere((element) => element.id == pc.miningToken!.id);
        final lastPriceToken = _priceTokenRepository.getLatestPriceByTokenId(token.id).cost;
        final countMined = powerMining / (lastPriceToken * 100);

        await _tokenRepository.changeToken(token, count: token.count + countMined);
        print('+ ${countMined.toStringAsFixed(8)} ${token.symbol}');
      }
    }
  }

  /// probabilityTrue = 60, probability = 40 => 60% to true
  bool _getMoveCrypto(int probabilityTrue, int probabilityFalse) {
    final sum = probabilityTrue + probabilityFalse;
    final generatedValue = Random().nextInt(sum);
    return generatedValue < probabilityTrue;
  }

  /// low = 1, high = 10 => 1% - 10% change 0.01 - 0.1
  double _getChangePercent(int low, int high) {
    final generatedValue = Random().nextInt(high - low) + low;
    return generatedValue / 100;
  }

  Future<void> _newPricesDay() async {
    final tokens = _tokenRepository.tokens;
    final oldPrices = <PriceToken>[];
    for (final token in tokens) {
      oldPrices.add(_priceTokenRepository.getLatestPriceByTokenId(token.id));
    }
    final newPrices = oldPrices.map((PriceToken price) {
      final isRaise = _getMoveCrypto(60, 40);
      final percentChange = isRaise ? 1 + _getChangePercent(1, 10) : 1 - _getChangePercent(1, 10);
      final newPrice = price.cost * percentChange;
      return price.copyWith(cost: newPrice, date: _game.date);
    });
    for (var price in newPrices) {
      await _priceTokenRepository.addPrice(price);
    }
  }
}
