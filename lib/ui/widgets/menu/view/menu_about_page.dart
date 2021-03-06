import 'package:crypto_tycoon/Theme/app_colors.dart';
import 'package:crypto_tycoon/Theme/app_fonts.dart';
import 'package:crypto_tycoon/Widgets/cirlce_animated_background_widget.dart';
import 'package:crypto_tycoon/generated/l10n.dart';
import 'package:crypto_tycoon/resources/resources.dart';
import 'package:crypto_tycoon/ui/widgets/menu/view/widgets/menu_app_bar_widget.dart';
import 'package:flutter/material.dart';

class MenuAboutWidget extends StatelessWidget {
  const MenuAboutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MenuAppBarWidget(),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ColoredBox(
            color: Theme.of(context).backgroundColor,
            child: _ContentWidget(),
          ),
        ),
      ),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: -50,
          top: -50,
          child: CircleAnimatedBackgroundWidget(
            size: 400,
            imagePath: AppBackgroundImages.circleGreen,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  S.of(context).game_authors_panteo,
                  style: AppFonts.clicker.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  'Panteo',
                  style: AppFonts.clicker.copyWith(color: AppColors.green),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: -50,
          bottom: -50,
          child: CircleAnimatedBackgroundWidget(
            isReverse: true,
            size: 400,
            imagePath: AppBackgroundImages.circleRed,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  S.of(context).game_authors_codex,
                  style: AppFonts.clicker.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  'Codex',
                  style: AppFonts.clicker.copyWith(color: AppColors.red),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
