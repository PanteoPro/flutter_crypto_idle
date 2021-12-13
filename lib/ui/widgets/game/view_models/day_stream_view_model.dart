import 'dart:async';
import 'dart:math';

import 'package:crypto_idle/domain/entities/news.dart';
import 'package:crypto_idle/domain/entities/price_token.dart';
import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/domain/repositories/flat_repository.dart';
import 'package:crypto_idle/domain/repositories/game_repository.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';
import 'package:crypto_idle/domain/repositories/news_repository.dart';
import 'package:crypto_idle/domain/repositories/pc_repository.dart';
import 'package:crypto_idle/domain/repositories/price_token_repository.dart';
import 'package:crypto_idle/domain/repositories/statistics_repository.dart';
import 'package:crypto_idle/domain/repositories/token_repository.dart';
import 'package:flutter/cupertino.dart';

class DayStreamViewModel extends ChangeNotifier {
  DayStreamViewModel() {
    _initialRepository();
    _initialDayStream();
  }

  @override
  void dispose() {
    _gameStreamSub?.cancel();
    _pcStreamSub?.cancel();
    _tokenStreamSub?.cancel();
    _priceTokenStreamSub?.cancel();
    _statisticsStreamSub?.cancel();
    _newsStreamSub?.cancel();
    _flatStreamSub?.cancel();
    _dayStreamSub.cancel();
    super.dispose();
  }

  double get _flatConsume => _flatRepository.currentFlat.costMonth;
  double get _energyConsumeCost => double.parse((_energyConsume / 30).toStringAsFixed(2));
  double get _energyConsume {
    var energy = 0.0;
    for (final element in _pcRepository.pcs) {
      if (element.miningToken != null) {
        energy += element.energy;
      }
    }
    return double.parse(energy.toStringAsFixed(2));
  }

  var newsListToDisplay = <News>[];
  void _updateNews() {
    _newsRepository.updateData();
    newsListToDisplay = _newsRepository.news.reversed.toList();
    notifyListeners();
  }

  final _priceTokenRepository = PriceTokenRepository();
  final _gameRepository = GameRepository();
  final _tokenRepository = TokenRepository();
  final _pcRepository = PCRepository();
  final _newsRepository = NewsRepository();
  final _statisticsRepository = StatisticsRepository();
  final _flatRepository = FlatRepository();
  StreamSubscription<dynamic>? _gameStreamSub;
  StreamSubscription<dynamic>? _pcStreamSub;
  StreamSubscription<dynamic>? _tokenStreamSub;
  StreamSubscription<dynamic>? _priceTokenStreamSub;
  StreamSubscription<dynamic>? _statisticsStreamSub;
  StreamSubscription<dynamic>? _newsStreamSub;
  StreamSubscription<dynamic>? _flatStreamSub;

  Future<void> _initialRepository() async {
    await _gameRepository.init();
    await _pcRepository.init();
    await _tokenRepository.init();
    await _priceTokenRepository.init();
    await _statisticsRepository.init();
    await _newsRepository.init();
    await _flatRepository.init();
    _updateNews();
    _subscriteStreams();
  }

  void _subscriteStreams() {
    _gameStreamSub = GameRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _gameRepository));
    _pcStreamSub = PCRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _pcRepository));
    _tokenStreamSub =
        TokenRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _tokenRepository));
    _priceTokenStreamSub =
        PriceTokenRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _priceTokenRepository));
    _statisticsStreamSub =
        StatisticsRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _statisticsRepository));
    _newsStreamSub = NewsRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _newsRepository));
    _flatStreamSub = NewsRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _flatRepository));
  }

  Future<void> _updateRepoByChangeEvent(dynamic data, MyRepository repository) async {
    repository.updateData();
    if (repository.runtimeType == NewsRepository) {
      _updateNews();
    }
  }

  static const lengthDaySeconds = 10;
  late Stream<dynamic> dayStream;
  late StreamSubscription<dynamic> _dayStreamSub;

  void _initialDayStream() {
    dayStream = Stream.periodic(const Duration(seconds: lengthDaySeconds), (int day) {
      return day;
    });
    _dayStreamSub = dayStream.listen(_newDay);
  }

  Future<void> _newDay(dynamic numberDaySession) async {
    await _gameRepository.nextDay();
    // await _gameRepository.changeData(date: _state.game?.date.add(Duration(days: 1)));
    await _miningDay();
    await newsDay();
    await _newPricesDay();
    await _checkMiningScamTokens();
    await _addNewToken();
    await _monthyPayments();
    if (_isMoneyGone()) {
      await _gameEnd();
    }
  }

  Future<void> _gameEnd() async {
    await _dayStreamSub.cancel();
    await _gameRepository.changeData(gameOver: true);
  }

  bool _isMoneyGone() {
    if (_gameRepository.game.money < 0) {
      return true;
    }
    return false;
  }

  Future<void> _monthyPayments() async {
    final nowDate = _gameRepository.game.date;
    final prevDate = nowDate.add(const Duration(days: -1));
    if (nowDate.day < prevDate.day) {
      await _gameRepository.changeData(money: _gameRepository.game.money - _flatConsume);
      await _gameRepository.changeData(money: _gameRepository.game.money - _energyConsumeCost);
      _newsRepository.createNewsByMonthyPayments(flat: _flatConsume, energy: _energyConsumeCost, date: nowDate);
    }
  }

  Future<void> _addNewToken() async {
    final dateNow = _gameRepository.game.date;
    final token = await _tokenRepository.createToken(dateNow);
    if (token != null) {
      await _priceTokenRepository.addInitialPricesForToken(token, dateNow);
      await _tokenRepository.addToken(token);
      _newsRepository.createNewsByNewToken(token, dateNow);
    }
  }

  List<PriceToken> _pricesByTokenId(int tokenId) =>
      _priceTokenRepository.prices.where((element) => element.tokenId == tokenId).toList();
  PriceToken _getLatestPriceByTokenId(int tokenId) => _pricesByTokenId(tokenId).last;

  Future<void> _checkMiningScamTokens() async {
    final scamTokens = <Token>[];
    for (final token in _tokenRepository.tokens) {
      final price = _getLatestPriceByTokenId(token.id);
      if (price.cost <= 0) {
        scamTokens.add(token);
      }
    }
    final pcsToChangeMining = _pcRepository.pcs.where((pc) {
      for (final scam in scamTokens) {
        if (scam.id == pc.miningToken?.id) {
          return true;
        }
      }
      return false;
    });
    for (final pc in pcsToChangeMining) {
      pc.miningToken = null;
      pc.save();
    }
  }

  Future<void> newsDay() async {
    _newsRepository.createNews(_gameRepository.game.date);
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
        await _statisticsRepository.addTokenMining(token, countMined);
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
    final news = _newsRepository.newsNotActivate;
    final newsAllCrypto = news.where((element) => element.isAllCrypto && !element.isActivate);
    News? newsOneGlobal;
    if (newsAllCrypto.isNotEmpty) {
      newsOneGlobal = newsAllCrypto.first;
    }
    newsOneGlobal?.isActivate = true;
    newsOneGlobal?.save();
    final newPrices = <PriceToken>[];
    for (var price in oldPrices) {
      if (price.cost > 0) {
        final newsForThisPrice = news.where((news) => news.tokenID == price.tokenId);
        var percentChange = 0.0;

        if (newsForThisPrice.isNotEmpty) {
          final newsOne = newsForThisPrice.first;
          newsOne.isActivate = true;
          newsOne.save();

          if (newsOne.newsTypeValue == NewsType.positive.index) {
            percentChange = 1 + _getChangePercent(30, 80);
          } else if (newsOne.newsTypeValue == NewsType.negative.index) {
            percentChange = 1 - _getChangePercent(15, 50);
          } else {
            percentChange = 1;
          }
          if (newsOne.isScamToken) {
            percentChange = 0;
          }
        } else {
          // without News
          final isRaise = _getMoveCrypto(55, 45);
          percentChange = isRaise ? 1 + _getChangePercent(1, 10) : 1 - _getChangePercent(1, 10);
        }
        if (newsOneGlobal != null && percentChange != 0.0) {
          if (newsOneGlobal.newsTypeValue == NewsType.positive.index) {
            percentChange += _getChangePercent(8, 12);
          } else if (newsOneGlobal.newsTypeValue == NewsType.negative.index) {
            percentChange -= _getChangePercent(8, 12);
          }
        }
        final newPrice = price.cost * percentChange;
        newPrices.add(price.copyWith(cost: newPrice, date: _gameRepository.game.date));
      }
    }
    for (final price in newPrices) {
      await _priceTokenRepository.addPrice(price);
    }
  }
}
