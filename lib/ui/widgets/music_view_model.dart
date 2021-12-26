import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:crypto_idle/domain/repositories/music_manager.dart';
import 'package:crypto_idle/resources/app_audio.dart';
import 'package:flutter/cupertino.dart';

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
      case MusicManagerStreamEvents.playMoney:
        _playMoney();
        break;
      case MusicManagerStreamEvents.mute:
        isMute = true;
        break;
      case MusicManagerStreamEvents.unmute:
        isMute = false;
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
    if (!isMute) {
      if (isPlayMain) {
        _startMainMusic();
      } else if (isPlayMenu) {
        _startMenuMusic();
      }
    } else {
      _endMainMusic();
      _endMenuMusic();
    }
  }

  /// Audio player variables
  final AudioCache _playerCacheMain = AudioCache();
  final AudioCache _playerCacheSounds = AudioCache();

  AudioPlayer? _playerMain;
  AudioPlayer? _playerSounds;

  var isPlayMain = false;
  var isPlayMenu = true;
  var isMute = false;

  Future<void> _startMainMusic() async {
    await _playerMain?.stop();
    _playerMain = await _playerCacheMain.loop(AppAudio.main);
    notifyListeners();
  }

  Future<void> _endMainMusic() async {
    await _playerMain?.stop();
    notifyListeners();
  }

  Future<void> _startMenuMusic() async {
    await _playerMain?.stop();
    _playerMain = await _playerCacheMain.loop(AppAudio.menu);
    notifyListeners();
  }

  Future<void> _endMenuMusic() async {
    await _playerMain?.stop();
    notifyListeners();
  }

  Future<void> _playMoney() async {
    await _playSound(AppAudio.money);
  }

  Future<void> _playSound(String soundPath) async {
    if (!isMute) {
      _playerSounds = await _playerCacheSounds.play(soundPath);
    }
  }
}
