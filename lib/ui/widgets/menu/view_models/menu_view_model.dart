import 'dart:async';

import 'package:crypto_tycoon/domain/repositories/game_repository.dart';
import 'package:crypto_tycoon/domain/repositories/music_manager.dart';
import 'package:crypto_tycoon/domain/repositories/my_repository.dart';
import 'package:crypto_tycoon/initial_data.dart';
import 'package:crypto_tycoon/ui/navigators/main_navigator.dart';
import 'package:crypto_tycoon/ui/widgets/game/view_models/global/game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuViewModelState {
  bool playMenu = false;
  bool isEndGame = true;
  bool isHaveGame = false;
}

class MenuViewModel extends ChangeNotifier {
  MenuViewModel(this.context) {
    initialRepositories();
  }

  final state = MenuViewModelState();

  final _gameRepository = GameRepository();
  Future<void> initialRepositories() async {
    await _gameRepository.init();
    state.isEndGame = _gameRepository.game.gameOver;
    state.isHaveGame = _gameRepository.game.date != DateTime(0);
    notifyListeners();
  }

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
    MusicManager.playClick();
    MusicManager.stopMenu();
    MusicManager.playMain();
    Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.game);
  }

  Future<void> onFreeGameButtonPressed() async {
    final dataManager = InitialDataManager();
    await dataManager.deleteBoxesFromDisk();
    await dataManager.init();
    MusicManager.playClick();
    MusicManager.stopMenu();
    MusicManager.playMain();
    Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.game);
  }

  void onPlayButtonPressed() {
    MusicManager.playClick();
    state.playMenu = true;
    notifyListeners();
  }

  void onBackFromPlayButtonPressed() {
    MusicManager.playClick();
    state.playMenu = false;
    notifyListeners();
  }

  void onSettingsButtonPressed() {
    MusicManager.playClick();
    Navigator.of(context).pushNamed(MainNavigationRouteNames.menuSettings);
  }

  void onAboutButtonPressed() {
    MusicManager.playClick();
    Navigator.of(context).pushNamed(MainNavigationRouteNames.menuAbout);
  }

  void onTestPage() {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.test);
  }
}
