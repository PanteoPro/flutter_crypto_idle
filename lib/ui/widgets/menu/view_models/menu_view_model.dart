import 'dart:async';

import 'package:crypto_idle/domain/repositories/game_repository.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';
import 'package:crypto_idle/initial_data.dart';
import 'package:crypto_idle/ui/navigators/main_navigator.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/global/game_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MenuViewModel extends ChangeNotifier {
  MenuViewModel(this.context) {
    initialRepositories();
  }

  final _gameRepository = GameRepository();
  Future<void> initialRepositories() async {
    await _gameRepository.init();
    isEndGame = _gameRepository.game.gameOver;
    notifyListeners();
  }

  bool isEndGame = true;

  final BuildContext context;

  void onCompanyGameButtonPressed() {
    Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.game);
  }

  Future<void> onContinueGameButtonPressed() async {
    // if (_gameRepository.game.gameOver) {
    //   final dataManager = InitialDataManager();
    //   await dataManager.deleteBoxesFromDisk();
    //   await dataManager.init();
    // }
    final dataManager = InitialDataManager();
    await dataManager.registerAllAdapters();
    // await context.read<GameViewModel>().initialRepository();
    Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.game);
  }

  Future<void> onFreeGameButtonPressed() async {
    final dataManager = InitialDataManager();
    await dataManager.deleteBoxesFromDisk();
    await dataManager.init();
    // await context.read<GameViewModel>().initialRepository();
    Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.game);
  }

  void onSettingsButtonPressed() {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.menuSettings);
  }

  void onAboutButtonPressed() {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.menuAbout);
  }

  void onTestPressed() {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.test);
  }

  void onNewDesignPressed() {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.newDesign);
  }
}
