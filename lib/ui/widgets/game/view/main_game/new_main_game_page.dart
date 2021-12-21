import 'dart:async';
import 'dart:math';

import 'package:crypto_idle/Theme/app_colors.dart';
import 'package:crypto_idle/Theme/app_fonts.dart';
import 'package:crypto_idle/Widgets/buttons/white_button_widget.dart';
import 'package:crypto_idle/domain/entities/game.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/resources/app_images.dart';
import 'package:crypto_idle/Libs/gif_lib.dart';
import 'package:crypto_idle/Widgets/circular_widget.dart';
import 'package:crypto_idle/ui/navigators/main_navigator.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/day_stream_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/main_game_view_model.dart';
import 'package:crypto_idle/ui/widgets/main_app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

part 'widgets/main_game_header_widget.dart';
part 'widgets/main_game_content_widget.dart';
part 'widgets/main_game_footer_widget.dart';
part 'widgets/main_game_app_bar_widget.dart';
part 'widgets/main_game_modal_exit_widget.dart';
part 'widgets/main_game_model_game_over_widget.dart';

class MainGamePage extends StatefulWidget {
  const MainGamePage({Key? key}) : super(key: key);

  @override
  State<MainGamePage> createState() => _MainGamePageState();
}

class _MainGamePageState extends State<MainGamePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Future<bool> didPopRoute() async {
    // Вызывается каждый раз, когда нажимается кнопка назад
    if (ModalRoute.of(context)?.isCurrent ?? false) {
      Navigator.of(context, rootNavigator: true).pushReplacementNamed(MainNavigationRouteNames.menu);
    } else {
      Navigator.of(context).pop();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final gameOver = context.read<GameViewModel>();
    return Scaffold(
      appBar: const _AppBarWidget(),
      body: Stack(
        children: [
          Column(
            children: const [
              _HeaderWidget(),
              Expanded(child: _ContentWidget()),
              _FooterWidget(),
            ],
          ),
          // _ModalExitWidget(),
          _ModalGameOverWidget(),
        ],
      ),
    );
  }
}
