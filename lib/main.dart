import 'package:crypto_idle/ui/main_app.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

// https://pub.dev/packages/syncfusion_flutter_charts Графики
Future<void> main() async {
  await Hive.initFlutter();
  runApp(MainApp());
}
