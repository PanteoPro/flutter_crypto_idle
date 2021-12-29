import 'package:crypto_idle/domain/repositories/music_manager.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/resources/resources.dart';
import 'package:crypto_idle/ui/widgets/music_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class MenuAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const MenuAppBarWidget({
    Key? key,
    this.automaticallyImplyLeading = true,
    this.isShowActions = true,
  }) : super(key: key);

  final bool automaticallyImplyLeading;
  final bool isShowActions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        S.of(context).menu_app_bar,
        style: const TextStyle(fontSize: 24),
      ),
      centerTitle: true,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: isShowActions
          ? const [
              _MuteActionWidget(),
              SizedBox(width: 12),
            ]
          : [],
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
    final isMute = context.select((MusicViewModel vm) => vm.isMuteMusic);
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
