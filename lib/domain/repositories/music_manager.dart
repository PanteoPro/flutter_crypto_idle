import 'dart:async';

import 'package:crypto_idle/resources/app_audio.dart';

enum MusicManagerStreamEvents {
  pause,
  resume,

  mute,
  unmute,

  playMain,
  stopMain,
  playMenu,
  stopMenu,

  playMoney,
}

class MusicManager {
  /// Using this method before use MessageManager
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

  static void playMoney() {
    _playSound(MusicManagerStreamEvents.playMoney);
  }

  static void _playSound(MusicManagerStreamEvents event) {
    _streamController.add(event);
  }
}
