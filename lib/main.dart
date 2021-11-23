import 'package:crypto_idle/ui/main_app.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'domain/entities/pc.dart';

// https://pub.dev/packages/syncfusion_flutter_charts Графики

Future<void> deleteAllHive() async {
  await Hive.deleteBoxFromDisk('pc');
  await Hive.deleteBoxFromDisk('pc_const');
  await Hive.deleteBoxFromDisk('game');
}

Future<void> firstData() async {
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
    _pcBox.put(key, pc);
    key += 1;
  }
}

Future<void> main() async {
  await Hive.initFlutter();
  await firstData();
  // await deleteAllHive();
  runApp(MainApp());
}
