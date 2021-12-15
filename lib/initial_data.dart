import 'dart:math';

import 'package:crypto_idle/config.dart';
import 'package:crypto_idle/domain/entities/flat.dart';
import 'package:crypto_idle/domain/entities/game.dart';
import 'package:crypto_idle/domain/entities/news.dart';
import 'package:crypto_idle/domain/entities/pc.dart';
import 'package:crypto_idle/domain/entities/price_token.dart';
import 'package:crypto_idle/domain/entities/statistics.dart';
import 'package:crypto_idle/domain/entities/token.dart';
import 'package:hive/hive.dart';

abstract class InitialDataNames {
  static const List<String> namePCs = [
    'LowPriority-D1',
    'LowPriority-D2',
    'Old GH-01',
    'Old GH-21',
    'Roberts Z1',
    'Roberts Z1-6',
    'Roberts 2Z-1',
    'Kertain Brown',
    'Morty T2000',
    'Rick K5',
    'iComp',
    'iComp 4',
    'iComp 5s',
    'iComp 6+',
    'iComp 13 pro',
    'MiComp Xm1',
    'MiComp Portable Zen2',
    'MiComp FCPU T2',
    'MiComp i9 Titanic',
    'Titan',
    'Titan Complexy',
    'Titan Full',
    'Prank PC',
    'Joker PC',
    'Griva Edition',
  ];
  static const List<String> nameFlats = [
    'Родительский дом',
    'Гараж деда',
    'Подвал',
    'Дом в лесу',
    'Просторная квартира',
    'Футуристичная квартира',
    'Офис на тверской',
    'Офис в Москва-Сити',
    'Коттетж',
    'Дата центр',
    'Квартира бабушки',
  ];
  static const Map<String, String> nameTokens = {
    'ISF': 'Income Soft Frame',
    'PRS': 'Proof Resistant Secure',
    'LVZ': 'Level Virus Zombie',
    'YROON': 'Young Roon',
    'AWES': 'Awesome weapon editions',
    'ZZU': 'Zettel Zeus Ultra',
    'CAT': 'Cat Coin',
    'SPD': 'Spider Coin',
    'MZS': 'Moscow Zero Social',
    'OLEG': 'Outbounded lego',
    'MCC': 'Minecraft club.clan',
    'FOAP': 'Fell On A Parrot',
    'BMF': 'Bit My Fork',
    'KDGH': 'Kingdom Global Hero',
    'PDF': 'Piece Drive Fatality ',
  };
  static Map<String, String> startTokens(int count) {
    final tokens = <String, String>{};
    final rnd = Random();
    while (tokens.length < min(count, nameTokens.length)) {
      final key = nameTokens.keys.elementAt(rnd.nextInt(nameTokens.length));
      tokens[key] = nameTokens[key]!;
    }
    return tokens;
  }

  static Map<String, String> getRandomToken() {
    final rndKey = nameTokens.keys.elementAt(Random().nextInt(nameTokens.length));
    return {rndKey: nameTokens[rndKey]!};
  }
}

abstract class InitialData {
  static const double minTooLowTokenPrice = 0.001;
  static const double maxTooLowTokenPrice = 0.1;
  static const double maxLowTokenPrice = 100;
  static const double maxTokenPrice = 4000.0;

  static List<PC> generatePCs() {
    const names = InitialDataNames.namePCs;
    var index = 0;
    final result = names.map((String name) {
      final cost = (AppConfig.kPcCosts[index]).toDouble();
      final costSell = cost * AppConfig.kSellPc;
      final power = cost * AppConfig.kVisualPower;
      final energy = cost * AppConfig.kVisualEnergy;
      final coefIncome = AppConfig.kStartIncomePC - (AppConfig.kDecreaseIncomePC * index);
      index += 1;
      return PC(
        id: index,
        name: name,
        cost: cost,
        costSell: costSell,
        power: power,
        energy: energy,
        coefIncome: coefIncome,
      );
    });
    return result.toList();
  }

  static List<Flat> generateFlats() {
    const names = InitialDataNames.nameFlats;
    var index = 0;
    final result = names.map((String name) {
      final cost = (AppConfig.kFlatCost[index]).toDouble();
      final costMonth = cost * AppConfig.kRentFlat;
      final countPC = AppConfig.kStartCountPc + index;
      final isBuy = index == 0 || false;
      final isActive = index == 0 || false;
      index += 1;
      return Flat(
        id: index,
        name: name,
        cost: cost,
        costMonth: costMonth,
        countPC: countPC,
        isBuy: isBuy,
        isActive: isActive,
      );
    });
    return result.toList();
  }

  static List<Token> generateTokens({Map<String, String>? tokenNames, int countGenerate = 5, int startIdToken = 1}) {
    final names = <String, String>{};
    if (tokenNames != null) {
      names.addAll(tokenNames);
    } else {
      names.addAll(InitialDataNames.startTokens(countGenerate));
    }
    var index = startIdToken;
    final result = names.entries.map((e) {
      final token = Token(
        id: index,
        symbol: e.key,
        fullName: e.value,
        count: 0,
        isScam: false,
      );
      index += 1;
      return token;
    });
    return result.toList();
  }

  static List<PriceToken> generatePrices(
      {required List<Token> tokens, required int dayHistoryCount, DateTime? startDate}) {
    final result = <PriceToken>[];
    final random = Random();
    var date = DateTime.now();
    if (startDate != null) {
      date = startDate;
    }
    for (final token in tokens) {
      final isLowPrice = random.nextBool();
      final isTooLowPrice = random.nextBool();

      final startCost = isLowPrice
          ? isTooLowPrice
              ? minTooLowTokenPrice
              : maxTooLowTokenPrice
          : maxLowTokenPrice;
      final endCost = isLowPrice
          ? isTooLowPrice
              ? maxTooLowTokenPrice
              : maxLowTokenPrice
          : maxTokenPrice;
      final cost = double.parse(
        (startCost + Random().nextDouble() * (endCost - startCost)).toStringAsFixed(3),
      );

      for (int i = 0; i < dayHistoryCount; i++) {
        final generatedValue = (Random().nextInt(3 - 1) + 1) / 100;
        final coefChanged = Random().nextBool() ? 1 + generatedValue : 1 - generatedValue;

        final price = PriceToken(
          date: date.add(Duration(days: -(dayHistoryCount - i))),
          cost: double.parse((cost * coefChanged).toStringAsFixed(4)),
          tokenId: token.id,
        );
        result.add(price);
      }
    }
    return result;
  }
}

class InitialDataManager {
  static const String pcConstBoxName = 'pc_const';
  static const String pcBoxName = 'pc';
  static const String gameBoxName = 'game';
  static const String flatBoxName = 'flat';
  static const String tokenBoxName = 'token';
  static const String priceTokenBoxName = 'price_token';
  static const String statisticsBoxName = 'statistics';
  static const String newsBoxName = 'news';

  Future<void> init() async {
    final needResetPCData = !await _checkPCData();
    final needResetHaveFlatData = !await _checkFlatData();
    final needResetHaveTokenData = !await _checkTokenData();
    final needResetHaveStatisticsData = !await _checkStatisticsData();

    if (needResetPCData) {
      print('reset PC DATA');
      await _deleteBoxFromDisk(pcBoxName);
      await _initPCData();
    }

    if (needResetHaveFlatData) {
      print('reset Flat DATA');
      await _deleteBoxFromDisk(flatBoxName);
      await _initFlatData();
    }

    if (needResetHaveTokenData) {
      print('reset Token DATA');
      print('reset Price DATA');

      await _deleteBoxFromDisk(tokenBoxName);
      await _deleteBoxFromDisk(priceTokenBoxName);
      await _initTokenData();
    }

    if (needResetHaveStatisticsData) {
      print('reset Statistics DATA');
      await _deleteBoxFromDisk(statisticsBoxName);
      await _initStatisticsData();
    }
  }

  Future<void> _deleteBoxFromDisk(String nameBox) async {
    await Hive.deleteBoxFromDisk(nameBox);
  }

  Future<void> deleteBoxesFromDisk() async {
    await Hive.deleteBoxFromDisk(pcConstBoxName);
    await Hive.deleteBoxFromDisk(pcBoxName);
    await Hive.deleteBoxFromDisk(gameBoxName);
    await Hive.deleteBoxFromDisk(flatBoxName);
    await Hive.deleteBoxFromDisk(tokenBoxName);
    await Hive.deleteBoxFromDisk(priceTokenBoxName);
    await Hive.deleteBoxFromDisk(statisticsBoxName);
    await Hive.deleteBoxFromDisk(newsBoxName);
  }

  Future<void> restartGame() async {
    final gameBox = await Hive.openBox<Game>(pcConstBoxName);
  }

  Future<void> registerAllAdapters() async {
    _registerAdapter<Game>(0, GameAdapter());
    _registerAdapter<PC>(1, PCAdapter());
    _registerAdapter<Flat>(2, FlatAdapter());
    _registerAdapter<Token>(3, TokenAdapter());
    _registerAdapter<PriceToken>(4, PriceTokenAdapter());
    _registerAdapter<Statistics>(5, StatisticsAdapter());
    _registerAdapter<News>(6, NewsAdapter());
  }

  void _registerAdapter<T>(int typeID, TypeAdapter<T> adapter) {
    if (!Hive.isAdapterRegistered(typeID)) {
      Hive.registerAdapter<T>(adapter);
    }
  }

  Future<void> _initPCData() async {
    final box = await Hive.openBox<PC>(pcConstBoxName);
    final pcs = InitialData.generatePCs();
    await box.addAll(pcs);
  }

  Future<bool> _checkPCData() async {
    _registerAdapter<PC>(1, PCAdapter());
    final box = await Hive.openBox<PC>(pcConstBoxName);
    if (box.isEmpty) {
      return false;
    }
    if (box.length != InitialDataNames.namePCs.length) {
      return false;
    }
    return true;
  }

  Future<void> _initFlatData() async {
    final box = await Hive.openBox<Flat>(flatBoxName);
    final flats = InitialData.generateFlats();
    await box.addAll(flats);
  }

  Future<bool> _checkFlatData() async {
    _registerAdapter<Flat>(2, FlatAdapter());
    final box = await Hive.openBox<Flat>(flatBoxName);
    if (box.isEmpty) {
      return false;
    }
    if (box.length != InitialDataNames.nameFlats.length) {
      return false;
    }
    return true;
  }

  Future<void> _initTokenData() async {
    final tokenBox = await Hive.openBox<Token>(tokenBoxName);
    final priceBox = await Hive.openBox<PriceToken>(priceTokenBoxName);

    final tokens = InitialData.generateTokens();
    print(tokens.length);
    final prices = InitialData.generatePrices(tokens: tokens, dayHistoryCount: 30);

    await tokenBox.addAll(tokens);
    await priceBox.addAll(prices);
  }

  Future<bool> _checkTokenData() async {
    _registerAdapter<Token>(3, TokenAdapter());
    _registerAdapter<PriceToken>(4, PriceTokenAdapter());
    final tokenBox = await Hive.openBox<Token>(tokenBoxName);
    final priceBox = await Hive.openBox<PriceToken>(priceTokenBoxName);
    if (tokenBox.isEmpty || priceBox.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> _initStatisticsData() async {
    final box = await Hive.openBox<Statistics>(statisticsBoxName);
    final statistics = Statistics.empty();
    await box.put(0, statistics);
  }

  Future<bool> _checkStatisticsData() async {
    _registerAdapter<Statistics>(5, StatisticsAdapter());
    final box = await Hive.openBox<Statistics>(statisticsBoxName);
    if (box.isEmpty) {
      return false;
    }
    return true;
  }
}
