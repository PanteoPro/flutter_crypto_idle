import 'package:crypto_tycoon/domain/repositories/message_manager.dart';
import 'package:crypto_tycoon/domain/repositories/music_manager.dart';
import 'package:crypto_tycoon/domain/repositories/statistics_manager.dart';
import 'package:crypto_tycoon/initial_data.dart';
import 'package:crypto_tycoon/ui/main_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  MessageManager.init();
  StatisticsManager.init();
  MusicManager.init();

  MobileAds.instance.initialize();
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
