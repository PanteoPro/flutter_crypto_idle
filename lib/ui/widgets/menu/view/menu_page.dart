import 'dart:async';
import 'dart:math';

import 'package:crypto_idle/Theme/app_colors.dart';
import 'package:crypto_idle/Theme/app_fonts.dart';
import 'package:crypto_idle/Widgets/cirlce_animated_background_widget.dart';
import 'package:crypto_idle/Widgets/game_button_widget.dart';
import 'package:crypto_idle/domain/repositories/music_manager.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/resources/resources.dart';
import 'package:crypto_idle/ui/widgets/main_app_view_model.dart';
import 'package:crypto_idle/ui/widgets/menu/view/widgets/menu_app_bar_widget.dart';
import 'package:crypto_idle/ui/widgets/menu/view_models/menu_view_model.dart';
import 'package:crypto_idle/ui/widgets/music_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.select((MainAppViewModel vm) => vm.locale);
    return Scaffold(
      appBar: const MenuAppBarWidget(),
      body: SafeArea(
        child: Stack(
          children: const [
            _BackgroundWidget(),
            Positioned(
              top: 50,
              bottom: 50,
              left: 0,
              child: CircleAnimatedBackgroundWidget(),
            ),
            _ButtonsWidget(),
            Positioned(bottom: 5, left: 5, child: _VersionWidget()),
          ],
        ),
      ),
    );
  }
}

class _BackgroundWidget extends StatelessWidget {
  const _BackgroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
    );
  }
}

class _ButtonsWidget extends StatelessWidget {
  const _ButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MenuViewModel>();
    final playMenu = context.select((MenuViewModel vm) => vm.state.playMenu);
    final isEndGame = context.select((MenuViewModel vm) => vm.state.isEndGame);
    final isHaveGame = context.select((MenuViewModel vm) => vm.state.isHaveGame);

    var buttons = <Widget>[];
    if (!playMenu) {
      buttons.addAll([
        GameButtonWidget.menuSmall(
          text: S.of(context).menu_button_play,
          onPressed: vm.onPlayButtonPressed,
        ),
        const SizedBox(height: 16),
        GameButtonWidget.menuSmall(
          text: S.of(context).menu_button_settings,
          onPressed: vm.onSettingsButtonPressed,
        ),
        const SizedBox(height: 16),
        GameButtonWidget.menuSmall(
          text: S.of(context).menu_button_authors,
          onPressed: vm.onAboutButtonPressed,
        ),
        const SizedBox(height: 16),
        GameButtonWidget.menuSmall(
          text: 'ТЕСТ',
          onPressed: vm.onTestPage,
        ),
      ]);
    } else {
      buttons.addAll([
        if (!isEndGame && isHaveGame)
          GameButtonWidget.menuBig(
            text: S.of(context).menu_button_continue_game,
            onPressed: vm.onContinueGameButtonPressed,
          ),
        const SizedBox(height: 16),
        GameButtonWidget.menuBig(
          text: S.of(context).menu_button_new_game,
          onPressed: vm.onFreeGameButtonPressed,
        ),
        const SizedBox(height: 16),
        GameButtonWidget.menuBig(
          text: S.of(context).menu_button_back,
          onPressed: vm.onBackFromPlayButtonPressed,
        ),
      ]);
    }

    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: buttons,
        ),
      ),
    );
  }
}

class _VersionWidget extends StatelessWidget {
  const _VersionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Version: 1.0.0',
      style: AppFonts.body.copyWith(color: AppColors.white),
    );
  }
}
