import 'package:crypto_tycoon/Libs/gif_lib.dart';
import 'package:crypto_tycoon/Theme/app_colors.dart';
import 'package:crypto_tycoon/Theme/app_fonts.dart';
import 'package:crypto_tycoon/domain/repositories/music_manager.dart';
import 'package:crypto_tycoon/resources/app_images.dart';
import 'package:crypto_tycoon/resources/resources.dart';
import 'package:crypto_tycoon/ui/widgets/game/view_models/global/game_view_model.dart';
import 'package:crypto_tycoon/ui/widgets/music_view_model.dart';
import 'package:crypto_tycoon/ui/widgets/game/view_models/main_game/main_game_view_model.dart';
import 'package:crypto_tycoon/ui/widgets/main_app_view_model.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

class GameAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const GameAppBarWidget({
    Key? key,
    this.isShowBackArrow = true,
  }) : super(key: key);

  final bool isShowBackArrow;

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          _DataWidget(),
        ],
      ),
      centerTitle: true,
      leading: isShowBackArrow && canPop
          ? _AppBarActionWidget(
              onTap: () {
                MusicManager.playClick();
                Navigator.of(context).pop();
              },
              imagePath: AppIconsImages.backArrow,
            )
          : null,
      actions: const [
        // const _MuteActionWidget(),
        SizedBox(width: 12),
        _SettingsActionWidget(),
        SizedBox(width: 12),
      ],
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(32);
}

class _SettingsActionWidget extends StatelessWidget {
  const _SettingsActionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<GameViewModel>();
    return _AppBarActionWidget(onTap: vm.onSettingsButtonPressed, imagePath: AppIconsImages.settingsIcon);
  }
}

class _MuteActionWidget extends StatelessWidget {
  const _MuteActionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MusicViewModel>();

    final isMuteMusic = context.select((MusicViewModel vm) => vm.musicSettings.isMuteMusic);
    final isMuteSound = context.select((MusicViewModel vm) => vm.musicSettings.isMuteSound);

    // MusicManager.mute(); MusicManager.unmute();
    final action = () {
      vm.onChangeMuteMusic(!isMuteMusic);
      vm.onChangeMuteSound(!isMuteSound);
    };
    final image = isMuteMusic && isMuteSound ? AppIconsImages.muteIcon : AppIconsImages.unmuteIcon;
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
