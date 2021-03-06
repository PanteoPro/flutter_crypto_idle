import 'dart:async';
import 'dart:math';

import 'package:crypto_tycoon/Theme/app_colors.dart';
import 'package:crypto_tycoon/Theme/app_fonts.dart';
import 'package:crypto_tycoon/Widgets/game_button_widget.dart';
import 'package:crypto_tycoon/Widgets/circle_index_widget.dart';
import 'package:crypto_tycoon/Widgets/game_over_widget.dart';
import 'package:crypto_tycoon/Widgets/page_wrapper.dart';
import 'package:crypto_tycoon/config.dart';
import 'package:crypto_tycoon/domain/entities/game.dart';
import 'package:crypto_tycoon/domain/entities/news.dart';
import 'package:crypto_tycoon/domain/entities/token.dart';
import 'package:crypto_tycoon/domain/repositories/music_manager.dart';
import 'package:crypto_tycoon/generated/l10n.dart';
import 'package:crypto_tycoon/resources/app_images.dart';
import 'package:crypto_tycoon/Libs/gif_lib.dart';
import 'package:crypto_tycoon/Widgets/circular_widget.dart';
import 'package:crypto_tycoon/resources/resources.dart';
import 'package:crypto_tycoon/ui/navigators/main_navigator.dart';
import 'package:crypto_tycoon/ui/widgets/game/view/general/game_app_bar_widget.dart';
import 'package:crypto_tycoon/ui/widgets/game/view/general/game_footer_widget.dart';
import 'package:crypto_tycoon/ui/widgets/game/view/general/game_header_balance_widget.dart';
import 'package:crypto_tycoon/ui/widgets/game/view_models/global/game_view_model.dart';
import 'package:crypto_tycoon/ui/widgets/game/view_models/main_game/clicker_game_view_model.dart';
import 'package:crypto_tycoon/ui/widgets/game/view_models/main_game/day_stream_view_model.dart';
import 'package:crypto_tycoon/ui/widgets/game/view_models/main_game/main_game_view_model.dart';
import 'package:crypto_tycoon/ui/widgets/main_app_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

part 'widgets/news_widget.dart';
part 'widgets/content_widget.dart';
part 'widgets/content_widgets/clicker_widget.dart';
part 'widgets/content_widgets/actions_widget.dart';
part 'widgets/content_widgets/computers_widget.dart';
part 'widgets/content_widgets/news_widget.dart';
part 'widgets/content_widgets/background_widget.dart';
part 'widgets/modal_exit_widget.dart';
part 'widgets/modal_list_tokens_widget.dart';
part 'widgets/modal_upgrade_widget.dart';

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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final dvm = context.read<DayStreamViewModel>();
    final cvm = context.read<ClickerGameViewModel>();
    if (state == AppLifecycleState.inactive) {
      dvm.pauseDayStream();
      cvm.pauseDelayClicker();
    } else if (state == AppLifecycleState.resumed) {
      dvm.resumeDayStream();
      cvm.resumeDelayClicker();
    }
  }

  @override
  Future<bool> didPopRoute() async {
    // ???????????????????? ???????????? ??????, ?????????? ???????????????????? ???????????? ??????????
    MusicManager.playClick();
    final vm = context.read<GameViewModel>();
    if (vm.state.isShowSettings) {
      vm.onSettingsButtonPressed();
    } else {
      if (ModalRoute.of(context)?.isCurrent ?? false) {
        final vm = context.read<MainGameViewModel>();
        final isModalShow = context.read<MainGameViewModel>().state.isModalExitShow;
        if (!isModalShow) {
          vm.onReturnToMenuButtonPressed();
        }
      } else if (vm.state.gameOver) {
        MusicManager.stopSound();
        context.read<MainGameViewModel>().onYesExitButtonPressed(context);
      } else {
        Navigator.of(context).pop();
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // final gameOver = context.select((GameViewModel vm) => vm.state.gameOver);
    // final vm = context.read<MainGameViewModel>();
    return PageWrapperWidget(
      modalWindows: const [
        _ModalListTokensWidget(),
        _ModalUpgradeWidget(),
        _ModalExitWidget(),
      ],
      child: Column(
        children: const [
          _NewsWidget(),
          Expanded(child: _ContentWidget()),
        ],
      ),
    );
  }
}
