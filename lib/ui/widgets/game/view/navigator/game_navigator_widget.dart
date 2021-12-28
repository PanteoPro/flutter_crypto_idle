import 'package:crypto_idle/ui/navigators/game_navigator.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/global/game_statistics_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/global/game_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/global/message_stream_view_model.dart';
import 'package:crypto_idle/ui/widgets/music_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameNavigatorWidget extends StatefulWidget {
  const GameNavigatorWidget({Key? key}) : super(key: key);

  @override
  _GameNavigatorWidgetState createState() => _GameNavigatorWidgetState();
}

class _GameNavigatorWidgetState extends State<GameNavigatorWidget> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GameViewModel(),
          lazy: false,
        ),
        ChangeNotifierProvider(create: (_) => MessageStreamViewModel()),
        ChangeNotifierProvider(
          create: (_) => GameStatisticsViewModel(),
          lazy: false,
        ),
      ],
      child: Navigator(
        onGenerateRoute: GameNavigation.onGenerateRoute,
        initialRoute: GameNavigation.initialRoute,
      ),
    );
  }
}
