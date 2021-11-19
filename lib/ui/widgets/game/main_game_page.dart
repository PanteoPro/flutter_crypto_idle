import 'package:crypto_idle/generated/l10n.dart';
import 'package:flutter/material.dart';

class MainGamePage extends StatelessWidget {
  const MainGamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).main_game_appbar_title,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
