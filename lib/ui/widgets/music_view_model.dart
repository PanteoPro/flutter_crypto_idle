import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:crypto_idle/domain/repositories/music_manager.dart';
import 'package:crypto_idle/resources/app_audio.dart';
import 'package:flutter/material.dart';

class MusicViewModel extends ChangeNotifier {
  MusicViewModel() {
    _musicStreamSub = MusicManager.stream?.listen(_streamChoicer);
    _startMenuMusic();
  }

  StreamSubscription<dynamic>? _musicStreamSub;

  @override
  void dispose() {
    _playerCacheMain.clearAll();
    _playerCacheSounds.clearAll();
    _playerMain?.stop();
    _playerSounds?.stop();
    _musicStreamSub?.cancel();
    super.dispose();
  }

  Future<void> _streamChoicer(event) async {
    final message = event as MusicManagerStreamEvents;
    switch (message) {
      case MusicManagerStreamEvents.playMain:
        isPlayMain = true;
        break;
      case MusicManagerStreamEvents.playMenu:
        isPlayMenu = true;
        break;
      case MusicManagerStreamEvents.stopMain:
        isPlayMain = false;
        break;
      case MusicManagerStreamEvents.stopMenu:
        isPlayMenu = false;
        break;
      case MusicManagerStreamEvents.playGameOver:
        _playGameOver();
        break;
      case MusicManagerStreamEvents.playBuy:
        _playBuy();
        break;
      case MusicManagerStreamEvents.playSell:
        _playBuy();
        break;
      case MusicManagerStreamEvents.playNews:
        break;
      case MusicManagerStreamEvents.playNewToken:
        break;
      case MusicManagerStreamEvents.playScamToken:
        break;
      case MusicManagerStreamEvents.playSelectToken:
        break;
      case MusicManagerStreamEvents.playClick:
        break;
      case MusicManagerStreamEvents.playClickPc:
        break;
      case MusicManagerStreamEvents.mute:
        isMuteMusic = true;
        isMuteSound = true;
        break;
      case MusicManagerStreamEvents.unmute:
        isMuteMusic = false;
        isMuteSound = false;
        break;
      case MusicManagerStreamEvents.pause:
        _pause();
        break;
      case MusicManagerStreamEvents.resume:
        _resume();
        break;
    }
    if (message == MusicManagerStreamEvents.mute ||
        message == MusicManagerStreamEvents.unmute ||
        message == MusicManagerStreamEvents.stopMenu ||
        message == MusicManagerStreamEvents.playMenu ||
        message == MusicManagerStreamEvents.stopMain ||
        message == MusicManagerStreamEvents.playMain) {
      _checkToPlay();
    }
  }

  void _checkToPlay() {
    print(isMuteMusic);
    if (!isMuteMusic) {
      if (isPlayMain) {
        _startMainMusic();
      } else {
        _endMainMusic();
      }
      if (isPlayMenu) {
        _startMenuMusic();
      } else {
        _endMenuMusic();
      }
    } else {
      _endMainMusic();
      _endMenuMusic();
    }
    notifyListeners();
  }

  /// Audio player variables
  final AudioCache _playerCacheMain = AudioCache();
  final AudioCache _playerCacheSounds = AudioCache();

  AudioPlayer? _playerMain;
  AudioPlayer? _playerSounds;

  var isPlayMain = false;
  var isPlayMenu = true;

  var isMuteMusic = false;
  var isMuteSound = false;

  var musicVolume = 1.0;
  var soundVolume = 1.0;

  void onChangeMuteMusic(bool value) {
    isMuteMusic = value;
    print(isMuteMusic);
    notifyListeners();
    _checkToPlay();
  }

  void onChangeMuteSound(bool value) {
    isMuteSound = value;
    notifyListeners();
  }

  void onChangeVolumeMusic(double volume) {
    musicVolume = volume;
    _playerMain?.setVolume(musicVolume);
    notifyListeners();
  }

  void onChangeVolumeSound(double volume) {
    soundVolume = volume;
    _playerSounds?.setVolume(soundVolume);
    notifyListeners();
  }

  Future<void> _pause() async {
    await _playerMain?.pause();
  }

  Future<void> _resume() async {
    if (!isMuteMusic) {
      await _playerMain?.resume();
    }
  }

  Future<void> _startMainMusic() async {
    await _playerMain?.stop();
    _playerMain = await _playerCacheMain.loop(AppAudio.main, volume: musicVolume);
    notifyListeners();
  }

  Future<void> _endMainMusic() async {
    await _playerMain?.stop();
    notifyListeners();
  }

  Future<void> _startMenuMusic() async {
    await _playerMain?.stop();
    _playerMain = await _playerCacheMain.loop(AppAudio.menu, volume: musicVolume);
    notifyListeners();
  }

  Future<void> _endMenuMusic() async {
    await _playerMain?.stop();
    notifyListeners();
  }

  Future<void> _playGameOver() async {
    await _playSound(AppAudio.gameOver);
  }

  Future<void> _playBuy() async {
    await _playSound(AppAudio.money);
  }

  Future<void> _playSound(String soundPath) async {
    if (!isMuteSound) {
      _playerSounds = await _playerCacheSounds.play(soundPath, volume: soundVolume);
    }
  }
}
