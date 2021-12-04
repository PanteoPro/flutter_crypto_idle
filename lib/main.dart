import 'package:crypto_idle/domain/entities/flat.dart';
import 'package:crypto_idle/domain/entities/game.dart';
import 'package:crypto_idle/domain/entities/price_token.dart';
import 'package:crypto_idle/domain/entities/statistics.dart';
import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/initial_data.dart';
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
  await Hive.deleteBoxFromDisk('statistics');
}

Future<void> firstDataPC() async {
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(PCAdapter());
  }
  final _pcBox = await Hive.openBox<PC>('pc_const');
  final pcs = InitialData.getInitialPCs();
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
  final flats = InitialData.getInitialFlats();
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

  final tokens = InitialData.getInitialTokens();
  final prices = InitialData.getInitialPrices(tokens);

  await _tokenBox.addAll(tokens);
  await _priceBox.addAll(prices);
}

Future<void> firstDataStatistics() async {
  if (!Hive.isAdapterRegistered(5)) {
    Hive.registerAdapter(StatisticsAdapter());
  }
  final _box = await Hive.openBox<Statistics>('statistics');
  final statistics = Statistics.empty();
  await _box.put(0, statistics);
}

Future<void> main() async {
  await Hive.initFlutter();
  await deleteAllHive();
  await firstDataPC();
  await firstDataFlat();
  await firstDataToken();
  await firstDataStatistics();
  runApp(MainApp());
}
