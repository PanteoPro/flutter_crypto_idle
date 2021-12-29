import 'package:crypto_idle/Theme/app_colors.dart';
import 'package:crypto_idle/Theme/app_fonts.dart';
import 'package:crypto_idle/Widgets/cirlce_animated_background_widget.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/resources/resources.dart';
import 'package:crypto_idle/ui/widgets/menu/view/widgets/menu_app_bar_widget.dart';
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
                  'Автор идеи/код',
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
            size: 400,
            imagePath: AppBackgroundImages.circleRed,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Дизайн',
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
