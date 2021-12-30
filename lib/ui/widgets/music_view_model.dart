import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:crypto_idle/domain/data_providers/settings_data_provider.dart';
import 'package:crypto_idle/domain/entities/settings.dart';
import 'package:crypto_idle/domain/repositories/music_manager.dart';
import 'package:crypto_idle/resources/app_audio.dart';
import 'package:flutter/material.dart';

class MusicViewModel extends ChangeNotifier {
  final _settingsDataProvider = SettingsDataProvider();
  MusicViewModel() {
    _musicStreamSub = MusicManager.stream?.listen(_streamChoicer);
    _startInitial();
  }

  var musicSettings = MusicSettings();

  Future<void> _startInitial() async {
    await _settingsDataProvider.init();
    musicSettings = _settingsDataProvider.getMusicSettings();
    _startMenuMusic();
  }

  Future<void> _saveSettings() async {
    _settingsDataProvider.saveMusicSettings(musicSettings);
  }

  StreamSubscription<dynamic>? _musicStreamSub;

  @override
  void dispose() {
    _playerCacheMain.clearAll();
    _playerCacheSounds.clearAll();
    _playerMain?.stop();
    _playerSounds?.stop();
    _musicStreamSub?.cancel();
    _saveSettings();
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
        _playSound(AppAudio.buy);
        break;
      case MusicManagerStreamEvents.playSell:
        _playSound(AppAudio.sell);
        break;
      case MusicManagerStreamEvents.playNews:
        _playSound(AppAudio.news);
        break;
      case MusicManagerStreamEvents.playNewToken:
        _playSound(AppAudio.newToken);
        break;
      case MusicManagerStreamEvents.playScamToken:
        _playSound(AppAudio.scamToken);
        break;
      case MusicManagerStreamEvents.playSelectToken:
        _playSound(AppAudio.selectToken);
        break;
      case MusicManagerStreamEvents.playClick:
        _playSound(AppAudio.click);
        break;
      case MusicManagerStreamEvents.playClickPc:
        _playSound(AppAudio.clickPC);
        break;
      case MusicManagerStreamEvents.mute:
        musicSettings.isMuteMusic = true;
        musicSettings.isMuteSound = true;
        break;
      case MusicManagerStreamEvents.unmute:
        musicSettings.isMuteMusic = false;
        musicSettings.isMuteSound = false;
        break;
      case MusicManagerStreamEvents.pause:
        _pause();
        break;
      case MusicManagerStreamEvents.resume:
        _resume();
        break;
      case MusicManagerStreamEvents.stopSound:
        _stopSound();
        break;
    }
    if (message == MusicManagerStreamEvents.mute ||
        message == MusicManagerStreamEvents.unmute ||
        message == MusicManagerStreamEvents.stopMenu ||
        message == MusicManagerStreamEvents.playMenu ||
        message == MusicManagerStreamEvents.stopMain ||
        message == MusicManagerStreamEvents.playMain) {
      _checkToPlay();
      _saveSettings();
    }
  }

  void _checkToPlay() {
    if (!musicSettings.isMuteMusic) {
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

  void onChangeMuteMusic(bool value) {
    musicSettings.isMuteMusic = value;
    notifyListeners();
    _checkToPlay();
    _saveSettings();
  }

  void onChangeMuteSound(bool value) {
    musicSettings.isMuteSound = value;
    notifyListeners();
    _saveSettings();
  }

  void onChangeVolumeMusic(double volume) {
    musicSettings.musicVolume = volume;
    _playerMain?.setVolume(musicSettings.musicVolume);
    notifyListeners();
    _saveSettings();
  }

  void onChangeVolumeSound(double volume) {
    musicSettings.soundVolume = volume;
    _playerSounds?.setVolume(musicSettings.soundVolume);
    notifyListeners();
    _saveSettings();
  }

  Future<void> _pause() async {
    await _playerMain?.pause();
  }

  Future<void> _resume() async {
    if (!musicSettings.isMuteMusic) {
      await _playerMain?.resume();
    }
  }

  Future<void> _startMainMusic() async {
    await _playerMain?.stop();
    _playerMain = await _playerCacheMain.loop(AppAudio.main, volume: musicSettings.musicVolume);
    notifyListeners();
  }

  Future<void> _stopSound() async {
    await _playerSounds?.stop();
    notifyListeners();
  }

  Future<void> _endMainMusic() async {
    await _playerMain?.stop();
    notifyListeners();
  }

  Future<void> _startMenuMusic() async {
    if (!musicSettings.isMuteMusic) {
      await _playerMain?.stop();
      _playerMain = await _playerCacheMain.loop(AppAudio.menu, volume: musicSettings.musicVolume);
      notifyListeners();
    }
  }

  Future<void> _endMenuMusic() async {
    await _playerMain?.stop();
    notifyListeners();
  }

  Future<void> _playGameOver() async {
    await _playSound(AppAudio.gameOver);
  }

  Future<void> _playSound(String soundPath) async {
    if (!musicSettings.isMuteSound) {
      _playerSounds = await _playerCacheSounds.play(soundPath, volume: musicSettings.soundVolume);
    }
  }
}
