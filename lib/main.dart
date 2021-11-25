import 'package:crypto_idle/domain/entities/flat.dart';
import 'package:crypto_idle/domain/entities/game.dart';
import 'package:crypto_idle/domain/entities/price_token.dart';
import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/ui/main_app.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'domain/entities/pc.dart';

// https://pub.dev/packages/syncfusion_flutter_charts Графики

Future<void> deleteAllHive() async {
  await Hive.deleteBoxFromDisk('pc');
  await Hive.deleteBoxFromDisk('pc_const');
  await Hive.deleteBoxFromDisk('game');
  await Hive.deleteBoxFromDisk('flat');
  await Hive.deleteBoxFromDisk('token');
  await Hive.deleteBoxFromDisk('price_token');
}

Future<void> firstDataPC() async {
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(PCAdapter());
  }
  final _pcBox = await Hive.openBox<PC>('pc_const');
  final pcs = <PC>[
    PC(id: 1, name: 'Старый ПК', cost: 50, costSell: 35, power: 48, energy: 220),
    PC(id: 2, name: 'Новый ПК', cost: 120, costSell: 70, power: 70, energy: 380),
    PC(id: 3, name: 'Крутой ПК', cost: 250, costSell: 170, power: 100, energy: 520),
  ];
  var key = 1;
  for (final PC pc in pcs) {
    await _pcBox.put(key, pc);
    key += 1;
  }
}

Future<void> firstDataFlat() async {
  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(FlatAdapter());
  }
  final _flatBox = await Hive.openBox<Flat>('flat');
  final flats = <Flat>[
    Flat(id: 1, name: 'Твоя квартира', cost: 0, costMonth: 0, countPC: 5, isBuy: true, isActive: true),
    Flat(id: 2, name: 'Отдельная квартира', cost: 1200, costMonth: 220, countPC: 8, isBuy: false, isActive: false),
    Flat(id: 2, name: 'Отдельная квартира 2', cost: 4200, costMonth: 804, countPC: 12, isBuy: false, isActive: false),
    Flat(id: 2, name: 'Отдельная квартира 3', cost: 12200, costMonth: 1234, countPC: 15, isBuy: false, isActive: false),
    Flat(id: 2, name: 'Отдельная квартира 4', cost: 42300, costMonth: 6342, countPC: 20, isBuy: false, isActive: false),
  ];
  var key = 1;
  for (final Flat flat in flats) {
    await _flatBox.put(key, flat);
    key += 1;
  }
}

Future<void> firstDataToken() async {
  if (!Hive.isAdapterRegistered(3)) {
    Hive.registerAdapter(TokenAdapter());
  }
  if (!Hive.isAdapterRegistered(4)) {
    Hive.registerAdapter(PriceTokenAdapter());
  }
  final _tokenBox = await Hive.openBox<Token>('token');
  final _priceBox = await Hive.openBox<PriceToken>('price_token');

  final tokens = <Token>[
    Token(id: 1, symbol: 'BTC', fullName: 'Bitcoin', count: 0.0003),
    Token(id: 2, symbol: 'ETC', fullName: 'Etherium classic', count: 0),
    Token(id: 3, symbol: 'ETH', fullName: 'Etherium', count: 0),
    Token(id: 4, symbol: 'BNB', fullName: 'Binance', count: 0),
    Token(id: 5, symbol: 'DOL', fullName: 'Deep of league', count: 0),
  ];

  final prices = <PriceToken>[
    PriceToken(date: DateTime.now(), cost: 1234.23, tokenId: 1),
    PriceToken(date: DateTime.now(), cost: 4234.23, tokenId: 1),
    PriceToken(date: DateTime.now(), cost: 434.23, tokenId: 2),
    PriceToken(date: DateTime.now(), cost: 234.12, tokenId: 3),
    PriceToken(date: DateTime.now(), cost: 23.00, tokenId: 4),
    PriceToken(date: DateTime.now(), cost: 0.023, tokenId: 5),
  ];

  await _tokenBox.addAll(tokens);
  await _priceBox.addAll(prices);
}

// Future<void> firstInitGame() async {
//   if (!Hive.isAdapterRegistered(0)) {
//     Hive.registerAdapter(GameAdapter());
//   }
//   final _gameBox = await Hive.openBox<Game>('game');
//   final game = _gameBox.get('main');
//   _gameBox.put('main', game!.copyWith(maxCountPC: 5));
// }

Future<void> main() async {
  await Hive.initFlutter();
  // await deleteAllHive();
  // await firstDataPC();
  // await firstDataFlat();
  // await firstDataToken();
  // await firstInitGame();
  runApp(MainApp());
}
