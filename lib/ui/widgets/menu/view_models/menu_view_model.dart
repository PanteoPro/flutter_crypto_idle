import 'package:crypto_idle/ui/navigators/main_navigator.dart';
import 'package:flutter/cupertino.dart';

class MenuViewModel {
  MenuViewModel(this.context);

  final BuildContext context;

  void onCompanyGameButtonPressed() {
    Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.gameMain);
  }

  void onFreeGameButtonPressed() {
    Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.gameMain);
  }

  void onSettingsButtonPressed() {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.menuSettings);
  }

  void onAboutButtonPressed() {}
}
