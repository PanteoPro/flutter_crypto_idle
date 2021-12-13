import 'package:crypto_idle/generated/l10n.dart';
import 'package:flutter/material.dart';

class MenuAboutWidget extends StatelessWidget {
  const MenuAboutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).manu_about_title,
          style: const TextStyle(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: const [
            _BackgroundWidget(),
            _ContentWidget(),
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
  const _ContentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(S.of(context).manu_about_by_title),
          Text(S.of(context).manu_about_dev_title),
        ],
      ),
    );
  }
}
