import 'package:crypto_tycoon/Theme/app_colors.dart';
import 'package:crypto_tycoon/Theme/app_fonts.dart';
import 'package:crypto_tycoon/Widgets/game_button_widget.dart';
import 'package:crypto_tycoon/Widgets/my_slider_widget.dart';
import 'package:crypto_tycoon/Widgets/my_switcher_widget.dart';
import 'package:crypto_tycoon/generated/l10n.dart';
import 'package:crypto_tycoon/ui/widgets/game/view_models/global/game_view_model.dart';
import 'package:crypto_tycoon/ui/widgets/music_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class SettingsModalWidget extends StatelessWidget {
  const SettingsModalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final closeCallback = context.read<GameViewModel>().onSettingsButtonPressed;
    final isShow = context.select((GameViewModel vm) => vm.state.isShowSettings);
    if (!isShow) return const SizedBox();
    return Stack(
      children: [
        GestureDetector(
          onTap: closeCallback,
          child: const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ColoredBox(color: AppColors.black50),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.mainGrey,
              border: Border.all(color: AppColors.green),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(S.of(context).game_settings_title, style: AppFonts.main.copyWith(color: AppColors.white)),
                  const SizedBox(height: 12),
                  const _MusicWidget(),
                  const SizedBox(height: 12),
                  const _SoundWidget(),
                  const SizedBox(height: 12),
                  GameButtonWidget.tokenSelect(
                    text: S.of(context).game_settings_close,
                    onPressed: closeCallback,
                    font: AppFonts.main,
                    backgroundColor: AppColors.secondGrey,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SoundWidget extends StatelessWidget {
  const _SoundWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            S.of(context).game_settings_sound,
            style: AppFonts.main.copyWith(color: AppColors.white),
            textAlign: TextAlign.right,
          ),
        ),
        const SizedBox(width: 5),
        const Expanded(flex: 4, child: _SliderSoundWidget()),
        const Expanded(child: _SwitcherSoundWidget()),
        const Spacer(),
      ],
    );
  }
}

class _SliderSoundWidget extends StatelessWidget {
  const _SliderSoundWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MusicViewModel>();
    final value = context.select((MusicViewModel vm) => vm.musicSettings.soundVolume);
    return MySliderWidget(
      value: value,
      callback: vm.onChangeVolumeSound,
    );
  }
}

class _SwitcherSoundWidget extends StatelessWidget {
  const _SwitcherSoundWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onChangeMuteSound = context.read<MusicViewModel>().onChangeMuteSound;
    final isMuteSound = context.select((MusicViewModel vm) => vm.musicSettings.isMuteSound);
    return MySwitcher(
      value: !isMuteSound,
      onChanged: (value) => onChangeMuteSound(!value),
    );
  }
}

class _MusicWidget extends StatelessWidget {
  const _MusicWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            S.of(context).game_settings_music,
            style: AppFonts.main.copyWith(color: AppColors.white),
            textAlign: TextAlign.right,
          ),
        ),
        const SizedBox(width: 5),
        const Expanded(flex: 4, child: _SliderMusicWidget()),
        const Expanded(child: _SwitcherMusicWidget()),
        const Spacer(),
      ],
    );
  }
}

class _SliderMusicWidget extends StatelessWidget {
  const _SliderMusicWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MusicViewModel>();
    final value = context.select((MusicViewModel vm) => vm.musicSettings.musicVolume);
    return MySliderWidget(
      value: value,
      callback: vm.onChangeVolumeMusic,
    );
  }
}

class _SwitcherMusicWidget extends StatelessWidget {
  const _SwitcherMusicWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onChangeMuteMusic = context.read<MusicViewModel>().onChangeMuteMusic;
    final isMuteMusic = context.select((MusicViewModel vm) => vm.musicSettings.isMuteMusic);
    return MySwitcher(
      value: !isMuteMusic,
      onChanged: (value) => onChangeMuteMusic(!value),
    );
  }
}
