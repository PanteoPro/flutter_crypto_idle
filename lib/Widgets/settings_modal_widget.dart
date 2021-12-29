import 'package:crypto_idle/Theme/app_colors.dart';
import 'package:crypto_idle/Theme/app_fonts.dart';
import 'package:crypto_idle/Widgets/game_button_widget.dart';
import 'package:crypto_idle/Widgets/my_slider_widget.dart';
import 'package:crypto_idle/Widgets/my_switcher_widget.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/global/game_view_model.dart';
import 'package:crypto_idle/ui/widgets/music_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class SettingsModalWidget extends StatelessWidget {
  const SettingsModalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final closeCallback = context.read<GameViewModel>().onSettingsButtonPressed;
    final isShow = context.select((GameViewModel vm) => vm.state.isShowSettings);
    if (!isShow) return SizedBox();
    return Stack(
      children: [
        const SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ColoredBox(color: AppColors.black50),
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
                  Text('Настройки', style: AppFonts.main.copyWith(color: AppColors.white)),
                  const SizedBox(height: 12),
                  const _MusicWidget(),
                  const SizedBox(height: 12),
                  const _SoundWidget(),
                  const SizedBox(height: 12),
                  GameButtonWidget.tokenSelect(
                    text: 'Закрыть',
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
            'Звуки',
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
    final value = context.select((MusicViewModel vm) => vm.soundVolume);
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
    final isMuteSound = context.select((MusicViewModel vm) => vm.isMuteSound);
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
            'Музыка',
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
    final value = context.select((MusicViewModel vm) => vm.musicVolume);
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
    final isMuteMusic = context.select((MusicViewModel vm) => vm.isMuteMusic);
    return MySwitcher(
      value: !isMuteMusic,
      onChanged: (value) => onChangeMuteMusic(!value),
    );
  }
}
