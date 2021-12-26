import 'dart:async';
import 'dart:math';

import 'package:crypto_idle/Widgets/buttons/game_button_widget.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/resources/resources.dart';
import 'package:crypto_idle/ui/widgets/main_app_view_model.dart';
import 'package:crypto_idle/ui/widgets/menu/view_models/menu_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.select((MainAppViewModel vm) => vm.locale);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).menu_game_title,
          style: const TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
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
      ]);
    } else {
      buttons.addAll([
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
    );
  }
}
