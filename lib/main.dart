import 'package:crypto_idle/domain/repositories/message_manager.dart';
import 'package:crypto_idle/initial_data.dart';
import 'package:crypto_idle/ui/main_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  await Hive.initFlutter();
  MessageManager.init();

  // final dataManager = InitialDataManager();
  // await dataManager.deleteBoxesFromDisk();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarColor: Colors.black, // status bar color
  ));
  runApp(const MainApp());
}
