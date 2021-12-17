import 'dart:async';
import 'dart:math';

import 'package:crypto_idle/domain/entities/game.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/resources/app_images.dart';
import 'package:crypto_idle/Libs/gif_lib.dart';
import 'package:crypto_idle/Widgets/circular_widget.dart';
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

class MainGamePage extends StatelessWidget {
  const MainGamePage({Key? key}) : super(key: key);

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
