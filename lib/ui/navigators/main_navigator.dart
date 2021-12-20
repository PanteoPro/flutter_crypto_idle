import 'package:crypto_idle/ui/navigators/game_navigator.dart';
import 'package:crypto_idle/ui/widgets/game/view/main_game/new_main_game_page.dart';
import 'package:crypto_idle/ui/widgets/game/view/navigator/game_navigator_widget.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/day_stream_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/main_game_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/message_stream_view_model.dart';
import 'package:crypto_idle/ui/widgets/menu/view/menu_about_page.dart';
import 'package:crypto_idle/ui/widgets/menu/view/menu_page.dart';
import 'package:crypto_idle/ui/widgets/menu/view/menu_settings_page.dart';
import 'package:crypto_idle/ui/widgets/menu/view/test_page.dart';
import 'package:crypto_idle/ui/widgets/menu/view_models/menu_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class MainNavigationRouteNames {
  static const game = 'game';
  static const menu = 'menu';
  static const menuSettings = 'menu/settings';
  static const menuAbout = 'menu/about';
  static const test = 'menu/test';
  static const newDesign = 'menu/newDesign';
}

class MainNavigation {
  String initialRoute() => MainNavigationRouteNames.menu;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.game: (context) => const GameNavigatorWidget(),
    MainNavigationRouteNames.menu: (context) =>
        ChangeNotifierProvider(create: (ctx) => MenuViewModel(ctx), child: const MenuWidget()),
    MainNavigationRouteNames.menuSettings: (context) => const MenuSettingsPage(),
    MainNavigationRouteNames.menuAbout: (context) => const MenuAboutWidget(),
    MainNavigationRouteNames.test: (context) => const TestWidget(),
    MainNavigationRouteNames.newDesign: (context) => const MainGamePage(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return MaterialPageRoute(builder: (_) => const Text('Main Navigation Error!'));
    }
  }
}
