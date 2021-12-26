import 'package:crypto_idle/Libs/gif_lib.dart';
import 'package:crypto_idle/Theme/app_colors.dart';
import 'package:crypto_idle/Theme/app_fonts.dart';
import 'package:crypto_idle/domain/repositories/music_manager.dart';
import 'package:crypto_idle/resources/app_images.dart';
import 'package:crypto_idle/resources/resources.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/global/game_view_model.dart';
import 'package:crypto_idle/ui/widgets/music_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/main_game/main_game_view_model.dart';
import 'package:crypto_idle/ui/widgets/main_app_view_model.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

class GameAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const GameAppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          _DataWidget(),
        ],
      ),
      centerTitle: true,
      actions: [
        const _MuteActionWidget(),
        const SizedBox(width: 12),
        _AppBarActionWidget(onTap: () {}, imagePath: AppIconsImages.settingsIcon),
        const SizedBox(width: 12),
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
    final image = isMute ? AppIconsImages.unmuteIcon : AppIconsImages.muteIcon;
    return _AppBarActionWidget(onTap: action, imagePath: image);
  }
}

class _DataWidget extends StatelessWidget {
  const _DataWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = context.read<MainAppViewModel>().locale;
    final format = DateFormat.yMd(locale.languageCode);
    final date = context.select((GameViewModel vm) => vm.state.date);
    final stringDate = format.format(date);
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: Text(
        stringDate,
        key: ValueKey(stringDate),
        style: AppFonts.main.copyWith(color: AppColors.white),
      ),
    );
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
