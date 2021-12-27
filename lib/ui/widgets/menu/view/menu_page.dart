import 'dart:async';
import 'dart:math';

import 'package:crypto_idle/Theme/app_colors.dart';
import 'package:crypto_idle/Theme/app_fonts.dart';
import 'package:crypto_idle/Widgets/buttons/game_button_widget.dart';
import 'package:crypto_idle/domain/repositories/music_manager.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/resources/resources.dart';
import 'package:crypto_idle/ui/widgets/main_app_view_model.dart';
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
      appBar: const _AppBarWidget(),
      body: SafeArea(
        child: Stack(
          children: const [
            _BackgroundWidget(),
            Positioned(
              top: 50,
              bottom: 50,
              left: 0,
              child: _CircleBackgroundWidget(),
            ),
            _ButtonsWidget(),
            Positioned(bottom: 5, left: 5, child: _VersionWidget()),
          ],
        ),
      ),
    );
  }
}

class _AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const _AppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        S.of(context).menu_game_title,
        style: const TextStyle(fontSize: 24),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: const [
        _MuteActionWidget(),
        SizedBox(width: 12),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(32);
}

class _MuteActionWidget extends StatelessWidget {
  const _MuteActionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMute = context.select((MusicViewModel vm) => vm.isMute);
    final action = isMute ? () => MusicManager.unmute() : () => MusicManager.mute();
    final image = isMute ? AppIconsImages.muteIcon : AppIconsImages.unmuteIcon;
    return _AppBarActionWidget(onTap: action, imagePath: image);
  }
}

class _AppBarActionWidget extends StatelessWidget {
  const _AppBarActionWidget({Key? key, required this.imagePath, required this.onTap}) : super(key: key);

  final VoidCallback onTap;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(imagePath, width: 20, height: 20),
    );
  }
}

class _CircleBackgroundWidget extends StatefulWidget {
  const _CircleBackgroundWidget({Key? key}) : super(key: key);

  @override
  __CircleBackgroundWidgetState createState() => __CircleBackgroundWidgetState();
}

class __CircleBackgroundWidgetState extends State<_CircleBackgroundWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: child,
        );
      },
      child: Image.asset(
        AppBackgroundImages.menuCircle,
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
          text: 'ИГРАТЬ',
          onPressed: vm.onPlayButtonPressed,
        ),
        const SizedBox(height: 16),
        GameButtonWidget.menuSmall(
          text: 'НАСТРОЙКИ',
          onPressed: vm.onSettingsButtonPressed,
        ),
        const SizedBox(height: 16),
        GameButtonWidget.menuSmall(
          text: 'АВТОРЫ',
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
            text: 'ПРОДОЛЖИТЬ',
            onPressed: vm.onContinueGameButtonPressed,
          ),
        const SizedBox(height: 16),
        GameButtonWidget.menuBig(
          text: 'НОВАЯ ИГРА',
          onPressed: vm.onFreeGameButtonPressed,
        ),
        const SizedBox(height: 16),
        GameButtonWidget.menuBig(
          text: 'НАЗАД',
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
