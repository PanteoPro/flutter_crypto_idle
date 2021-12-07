import 'dart:math';

import 'package:crypto_idle/domain/entities/flat.dart';
import 'package:crypto_idle/domain/entities/pc.dart';
import 'package:crypto_idle/domain/entities/price_token.dart';
import 'package:crypto_idle/domain/entities/token.dart';

abstract class InitialDataNames {
  static const List<String> namesPC = [
    'LowPriority-D1',
    'LowPriority-D2',
    'Старый ПК GH-01',
    'Старый ПК GH-21',
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
  static const List<String> namesFlat = [
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
  static const Map<String, String> namesCrypto = {
    'ISF': 'Income Soft Frame',
    'PRS': 'Proof Resistant Secure',
    'LVZ': 'Level Virus Zombie',
    // 'YROON': 'Young Roon',
    // 'AWE': 'Awesome weapon edition',
    // 'ZZU': 'Zettel Zeus Ultra',
    // 'CAT': 'Cat Coin',
    // 'SPD': 'Spider Coin',
    // 'MZS': 'Moscow Zero Social',
    // 'OLEG': 'Outbounded lego',
    // 'MCC': 'Minecraft club.clan',
    // 'FOAP': 'Fell On A Parrot',
    // 'BMF': 'Bit My Fork',
    // 'KDGH': 'Kingdom Global Hero',
    // 'PDF': 'Piece Drive Fatality ',
  };
}

abstract class InitialData {
  static const int baseCostPC = 100;
  static const double sellCoefPC = 0.6;
  static const int basePowerPC = 150;
  static const int baseEnergyPC = 200;

  static const int baseCostFlat = 1000;
  static const int baseMonthCostFlat = 200;
  static const int baseCountPC = 5;

  static const double minTooLowTokenPrice = 0.001;
  static const double maxTooLowTokenPrice = 0.1;
  static const double maxLowTokenPrice = 100;
  static const double maxTokenPrice = 4000.0;

  static List<PC> getInitialPCs() {
    const names = InitialDataNames.namesPC;
    var index = 1;
    final result = names.map((String name) {
      final cost = (baseCostPC * index).toDouble();
      final costSell = cost * sellCoefPC;
      final power = (basePowerPC * index).toDouble();
      final energy = (baseEnergyPC * index).toDouble();
      index += 1;
      return PC(id: index, name: name, cost: cost, costSell: costSell, power: power, energy: energy);
    });
    return result.toList();
  }

  static List<Flat> getInitialFlats() {
    const names = InitialDataNames.namesFlat;
    var index = 1;
    final result = names.map((String name) {
      final cost = (baseCostFlat * (index - 1)).toDouble();
      final costMonth = (baseMonthCostFlat * (index - 1)).toDouble();
      final countPC = baseCountPC + index - 1;
      final isBuy = index == 1 || false;
      final isActive = index == 1 || false;
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

  static List<Token> getInitialTokens() {
    const names = InitialDataNames.namesCrypto;
    var index = 1;
    final result = names.entries.map((e) {
      final token = Token(
        id: index,
        symbol: e.key,
        fullName: e.value,
        count: 0,
        coefMining: 0,
      );
      index += 1;
      return token;
    });
    return result.toList();
  }

  static List<PriceToken> getInitialPrices({required List<Token> tokens, required int dayHistoryCount}) {
    final result = <PriceToken>[];
    final random = Random();
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
        result.add(
          PriceToken(
            date: DateTime.now().add(Duration(days: -(dayHistoryCount - i))),
            cost: double.parse((cost * coefChanged).toStringAsFixed(4)),
            tokenId: token.id,
          ),
        );
      }
    }
    return result;
  }
}
