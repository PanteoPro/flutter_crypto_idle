import 'package:crypto_tycoon/Theme/app_colors.dart';
import 'package:crypto_tycoon/Theme/app_fonts.dart';
import 'package:crypto_tycoon/Widgets/cirlce_animated_background_widget.dart';
import 'package:crypto_tycoon/Widgets/game_button_widget.dart';
import 'package:crypto_tycoon/Widgets/my_slider_widget.dart';
import 'package:crypto_tycoon/Widgets/my_switcher_widget.dart';
import 'package:crypto_tycoon/generated/l10n.dart';
import 'package:crypto_tycoon/resources/resources.dart';
import 'package:crypto_tycoon/ui/widgets/main_app_view_model.dart';
import 'package:crypto_tycoon/ui/widgets/menu/view/widgets/menu_app_bar_widget.dart';
import 'package:crypto_tycoon/ui/widgets/music_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuSettingsPage extends StatelessWidget {
  const MenuSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = 50.0;
    const appBarHeight = 32;
    final sizeCircle = MediaQuery.of(context).size.height - padding * 2 - appBarHeight;
    final diffirence = sizeCircle - MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const MenuAppBarWidget(isShowActions: false),
      body: SafeArea(
        child: Stack(
          children: [
            const _BackgroundWidget(),
            Positioned(
              top: padding,
              bottom: padding,
              left: -diffirence / 2,
              child: CircleAnimatedBackgroundWidget(
                size: sizeCircle,
              ),
            ),
            const _ContentWidget(),
          ],
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
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).menu_settings_title,
            style: AppFonts.main.copyWith(color: AppColors.white),
          ),
          const SizedBox(height: 12),
          const _MusicSwitchWidget(),
          const SizedBox(height: 12),
          const _MusicSliderWidget(),
          const SizedBox(height: 12),
          const _SoundSwitchWidget(),
          const SizedBox(height: 12),
          const _SoundSliderWidget(),
          const SizedBox(height: 12),
          Text(
            S.of(context).menu_settings_language,
            style: AppFonts.clicker.copyWith(color: AppColors.white),
          ),
          const SizedBox(height: 4),
          Row(
            children: const [
              Spacer(flex: 2),
              Expanded(flex: 3, child: _LanguageWidget()),
              Spacer(flex: 2),
            ],
          )
        ],
      ),
    );
  }
}

class _LanguageWidget extends StatelessWidget {
  const _LanguageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MainAppViewModel>();
    final locale = context.select((MainAppViewModel vm) => vm.locale);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _LanguageItem(callback: vm.setLocaleRu, image: AppIconsImages.ru, isActive: locale.languageCode == 'ru'),
        _LanguageItem(callback: vm.setLocaleEn, image: AppIconsImages.en, isActive: locale.languageCode == 'en'),
      ],
    );
  }
}

class _LanguageItem extends StatelessWidget {
  const _LanguageItem({
    Key? key,
    required this.callback,
    required this.image,
    this.isActive = false,
  }) : super(key: key);

  final VoidCallback callback;
  final String image;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: GestureDetector(
        onTap: callback,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isActive ? AppColors.green : Colors.transparent,
          ),
          child: Image.asset(image, width: 64, height: 64),
        ),
      ),
    );
  }
}

class _MusicSliderWidget extends StatelessWidget {
  const _MusicSliderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MusicViewModel>();
    final value = context.select((MusicViewModel vm) => vm.musicSettings.musicVolume);
    return Row(
      children: [
        Spacer(flex: 2),
        Expanded(
          flex: 3,
          child: MySliderWidget(
            value: value,
            callback: vm.onChangeVolumeMusic,
            leftPaddings: 0,
          ),
        ),
        Spacer(flex: 2),
      ],
    );
  }
}

class _SoundSliderWidget extends StatelessWidget {
  const _SoundSliderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MusicViewModel>();
    final value = context.select((MusicViewModel vm) => vm.musicSettings.soundVolume);
    return Row(
      children: [
        Spacer(flex: 2),
        Expanded(
          flex: 3,
          child: MySliderWidget(
            value: value,
            callback: vm.onChangeVolumeSound,
            leftPaddings: 0,
          ),
        ),
        Spacer(flex: 2),
      ],
    );
  }
}

class _SoundSwitchWidget extends StatelessWidget {
  const _SoundSwitchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onChangeMuteSound = context.read<MusicViewModel>().onChangeMuteSound;
    final isMuteSound = context.select((MusicViewModel vm) => vm.musicSettings.isMuteSound);
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Spacer(flex: 2),
        Expanded(
          child: Text(
            S.of(context).menu_settings_sound,
            style: AppFonts.main.copyWith(color: AppColors.white),
            textAlign: TextAlign.left,
          ),
        ),
        const Spacer(),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: MySwitcher(
              value: !isMuteSound,
              onChanged: (value) => onChangeMuteSound(!value),
            ),
          ),
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}

class _MusicSwitchWidget extends StatelessWidget {
  const _MusicSwitchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onChangeMuteMusic = context.read<MusicViewModel>().onChangeMuteMusic;
    final isMuteMusic = context.select((MusicViewModel vm) => vm.musicSettings.isMuteMusic);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Spacer(flex: 2),
        Expanded(
          child: Text(
            S.of(context).menu_settings_music,
            style: AppFonts.main.copyWith(color: AppColors.white),
            textAlign: TextAlign.left,
          ),
        ),
        Spacer(),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: MySwitcher(
              value: !isMuteMusic,
              onChanged: (value) => onChangeMuteMusic(!value),
            ),
          ),
        ),
        Spacer(flex: 2),
      ],
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
