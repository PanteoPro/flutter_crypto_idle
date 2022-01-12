import 'dart:async';

import 'package:crypto_tycoon/resources/app_audio.dart';

enum MusicManagerStreamEvents {
  pause,
  resume,

  mute,
  unmute,

  playMain,
  stopMain,
  playMenu,
  stopMenu,
  stopSound,

  playGameOver,

  playBuy,
  playSell,
  playNews,
  playNewToken,
  playScamToken,
  playSelectToken,
  playClick,
  playClickPc,
}

class MusicManager {
  /// Using this method before use MusicManager
  static void init() {
    stream ??= _streamController.stream.asBroadcastStream();
  }

  static final _streamController = StreamController<dynamic>();
  static Stream<dynamic>? stream;

  static void pause() {
    _playSound(MusicManagerStreamEvents.pause);
  }

  static void resume() {
    _playSound(MusicManagerStreamEvents.resume);
  }

  static void mute() {
    _playSound(MusicManagerStreamEvents.mute);
  }

  static void unmute() {
    _playSound(MusicManagerStreamEvents.unmute);
  }

  static void stopSound() {
    _playSound(MusicManagerStreamEvents.stopSound);
  }

  static void playMain() {
    _playSound(MusicManagerStreamEvents.playMain);
  }

  static void stopMain() {
    _playSound(MusicManagerStreamEvents.stopMain);
  }

  static void playMenu() {
    _playSound(MusicManagerStreamEvents.playMenu);
  }

  static void stopMenu() {
    _playSound(MusicManagerStreamEvents.stopMenu);
  }

  static void playGameOver() {
    _playSound(MusicManagerStreamEvents.playGameOver);
  }

  static void playBuy() {
    _playSound(MusicManagerStreamEvents.playBuy);
  }

  static void playSell() {
    _playSound(MusicManagerStreamEvents.playSell);
  }

  static void playNews() {
    _playSound(MusicManagerStreamEvents.playNews);
  }

  static void playNewToken() {
    _playSound(MusicManagerStreamEvents.playNewToken);
  }

  static void playScamToken() {
    _playSound(MusicManagerStreamEvents.playScamToken);
  }

  static void playSelectToken() {
    _playSound(MusicManagerStreamEvents.playSelectToken);
  }

  static void playClick() {
    _playSound(MusicManagerStreamEvents.playClick);
  }

  static void playClickPc() {
    _playSound(MusicManagerStreamEvents.playClickPc);
  }

  static void _playSound(MusicManagerStreamEvents event) {
    _streamController.add(event);
  }
}
