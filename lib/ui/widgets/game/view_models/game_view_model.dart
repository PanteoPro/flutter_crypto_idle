import 'dart:async';
import 'dart:math';

import 'package:crypto_idle/domain/entities/flat.dart';
import 'package:crypto_idle/domain/entities/game.dart';
import 'package:crypto_idle/domain/entities/news.dart';
import 'package:crypto_idle/domain/entities/pc.dart';
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

class GameViewModelState {
  GameViewModelState({
    required this.game,
    required this.pcs,
    required this.flats,
    required this.currentPrices,
    required this.tokens,
  });
  const GameViewModelState.empty({
    this.game,
    this.pcs = const [],
    this.flats = const [],
    this.currentPrices = const {},
    this.tokens = const [],
  });
  final Game? game;
  final List<PC> pcs;
  final List<Flat> flats;
  final Map<int, double> currentPrices;
  final List<Token> tokens;

  int get currentCountPC => pcs.length;
  int get maxCountPC => flats.firstWhere((element) => element.isActive).countPC;

  double getPriceByToken(Token token) {
    return currentPrices[token.id]!;
  }

  double get balance {
    double balance = 0;
    for (final Token token in tokens) {
      balance += getPriceByToken(token) * token.count;
    }
    return double.parse(balance.toStringAsFixed(2));
  }
}

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
    _statisticsStreamSub?.cancel();
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
  final _statisticsRepository = StatisticsRepository();
  final _newsRepository = NewsRepository();

  StreamSubscription<dynamic>? _gameStreamSub;
  StreamSubscription<dynamic>? _pcStreamSub;
  StreamSubscription<dynamic>? _flatStreamSub;
  StreamSubscription<dynamic>? _tokenStreamSub;
  StreamSubscription<dynamic>? _priceTokenStreamSub;
  StreamSubscription<dynamic>? _statisticsStreamSub;

  // Data
  var _state = GameViewModelState.empty();
  GameViewModelState get state => _state;

  var newsListToDisplay = <News>[];

  /// Initial Repository
  Future<void> _initialRepository() async {
    await _gameRepository.init();
    await _pcRepository.init();
    await _flatRepository.init();
    await _tokenRepository.init();
    await _priceTokenRepository.init();
    await _statisticsRepository.init();
    await _newsRepository.init();
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
        PriceTokenRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _priceTokenRepository));
    _statisticsStreamSub =
        StatisticsRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _statisticsRepository));
  }

  Future<void> _updateRepoByChangeEvent(dynamic data, MyRepository repository) async {
    await repository.updateData();
    updateState();
  }

  void updateState() {
    final currentPrices = <int, double>{};
    final currentTokens = _tokenRepository.tokens;
    for (final token in currentTokens) {
      currentPrices[token.id] = _priceTokenRepository.getLatestPriceByTokenId(token.id).cost;
    }
    _state = GameViewModelState(
      game: _gameRepository.game.copyWith(),
      flats: _flatRepository.flats,
      pcs: _pcRepository.pcs,
      currentPrices: currentPrices,
      tokens: currentTokens,
    );
    notifyListeners();
  }

  Future<void> changeMoney(double money) async {
    await _gameRepository.changeData(money: money);
    updateState();
  }

  // New day logic

  Future<void> _newDay(dynamic numberDaySession) async {
    await _gameRepository.nextDay();
    // await _gameRepository.changeData(date: _state.game?.date.add(Duration(days: 1)));
    await _miningDay();
    await newsDay();
    await _newPricesDay();
    await _checkMiningScamTokens();
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
    print(scamTokens);
    for (final pc in pcsToChangeMining) {
      pc.miningToken = null;
      pc.save();
    }
  }

  Future<void> newsDay() async {
    final isCreated = _newsRepository.createNews(_state.game!.date);
    if (isCreated) {
      await _newsRepository.updateData();
      newsListToDisplay = _newsRepository.news.reversed.toList();
    }
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
        newPrices.add(price.copyWith(cost: newPrice, date: _state.game?.date));
      }
    }
    for (final price in newPrices) {
      await _priceTokenRepository.addPrice(price);
    }
  }

  void BABLO() {
    _gameRepository.changeData(money: _state.game!.money + 100);
  }
}
