import 'package:crypto_idle/domain/repositories/game_repository.dart';
import 'package:crypto_idle/initial_data.dart';
import 'package:crypto_idle/ui/navigators/main_navigator.dart';
import 'package:flutter/cupertino.dart';

class MenuViewModel {
  MenuViewModel(this.context);

  final BuildContext context;

  void onCompanyGameButtonPressed() {
    Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.gameMain);
  }

  Future<void> onFreeGameButtonPressed() async {
    final gr = GameRepository();
    await gr.init();
    if (gr.game.gameOver) {
      final dataManager = InitialDataManager();
      await dataManager.deleteBoxesFromDisk();
      await dataManager.init();
    }
    Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.gameMain);
  }

  void onSettingsButtonPressed() {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.menuSettings);
  }

  void onAboutButtonPressed() {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.menuAbout);
  }
}
