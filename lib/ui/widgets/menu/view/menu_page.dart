import 'package:crypto_idle/Widgets/buttons.dart';
import 'package:crypto_idle/ui/widgets/menu/view_models/menu_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Меню',
          style: const TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Stack(
          children: const [
            _BackgroundWidget(),
            _ContentWidget(),
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

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          _TitleWidget(),
          SizedBox(height: 10),
          _ButtonsWidget(),
        ],
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Криптовалютный IDLE');
  }
}

class _ButtonsWidget extends StatelessWidget {
  const _ButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MenuViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Column(
        children: [
          SizedBox(
              width: double.infinity,
              child: MyButton(
                  color: Theme.of(context).splashColor,
                  onPressed: vm.onCompanyGameButtonPressed,
                  title: 'Начать компанию')),
          SizedBox(
            width: double.infinity,
            child: MyButton(
                color: Theme.of(context).splashColor,
                onPressed: vm.onFreeGameButtonPressed,
                title: 'Начать свободную игру'),
          ),
          SizedBox(
              width: double.infinity,
              child: MyButton(
                  color: Theme.of(context).splashColor, onPressed: vm.onSettingsButtonPressed, title: 'Настройки')),
          SizedBox(
              width: double.infinity,
              child: MyButton(
                  color: Theme.of(context).splashColor, onPressed: vm.onAboutButtonPressed, title: 'Об авторе')),
        ],
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
