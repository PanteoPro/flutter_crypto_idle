import 'dart:async';
import 'dart:math';

import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/resources/app_images.dart';
import 'package:crypto_idle/Libs/gif_lib.dart';
import 'package:crypto_idle/Widgets/circular_widget.dart';
import 'package:flutter/material.dart';

part 'widgets/main_game_header_widget.dart';
part 'widgets/main_game_content_widget.dart';
part 'widgets/main_game_footer_widget.dart';
part 'widgets/main_game_app_bar_widget.dart';

class MainGamePageW extends StatelessWidget {
  const MainGamePageW({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBarWidget(),
      body: Column(
        children: const [
          _HeaderWidget(),
          Expanded(child: _ContentWidget()),
          _FooterWidget(),
        ],
      ),
    );
  }
}
