import 'package:crypto_idle/Theme/app_colors.dart';
import 'package:crypto_idle/Theme/app_fonts.dart';
import 'package:crypto_idle/Widgets/cirlce_animated_background_widget.dart';
import 'package:crypto_idle/Widgets/game_button_widget.dart';
import 'package:crypto_idle/Widgets/my_slider_widget.dart';
import 'package:crypto_idle/Widgets/my_switcher_widget.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/resources/resources.dart';
import 'package:crypto_idle/ui/widgets/main_app_view_model.dart';
import 'package:crypto_idle/ui/widgets/menu/view/widgets/menu_app_bar_widget.dart';
import 'package:crypto_idle/ui/widgets/music_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuSettingsPage extends StatelessWidget {
  const MenuSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MenuAppBarWidget(isShowActions: false),
      body: SafeArea(
        child: Stack(
          children: [
            const _BackgroundWidget(),
            Positioned(
              top: 30,
              bottom: 30,
              left: -MediaQuery.of(context).size.width / 2,
              right: -MediaQuery.of(context).size.width / 2,
              child: const CircleAnimatedBackgroundWidget(),
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
            'ЯЗЫК',
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: vm.setLocaleRu,
          child: Image.asset(AppIconsImages.ru, width: 64, height: 64),
        ),
        GestureDetector(
          onTap: vm.setLocaleEn,
          child: Image.asset(AppIconsImages.en, width: 64, height: 64),
        ),
      ],
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
    final value = context.select((MusicViewModel vm) => vm.musicVolume);
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
    final value = context.select((MusicViewModel vm) => vm.soundVolume);
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
    final isMuteSound = context.select((MusicViewModel vm) => vm.isMuteSound);
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Spacer(flex: 2),
        Expanded(
          child: Text(
            'Звуки',
            style: AppFonts.main.copyWith(color: AppColors.white),
            textAlign: TextAlign.left,
          ),
        ),
        Spacer(),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: MySwitcher(
              value: !isMuteSound,
              onChanged: (value) => onChangeMuteSound(!value),
            ),
          ),
        ),
        Spacer(flex: 2),
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
    final isMuteMusic = context.select((MusicViewModel vm) => vm.isMuteMusic);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Spacer(flex: 2),
        Expanded(
          child: Text(
            'Музыка',
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
