import 'dart:async';

import 'package:flutter/material.dart';

class AppMessage {
  AppMessage({required this.text, required this.color});
  final String text;
  final Color color;
}

/// Before using, call the init()
/// For listen change messages listen the stream field
class MessageManager {
  /// Using this method before use MessageManager
  static void init() {
    stream ??= _streamController.stream.asBroadcastStream();
  }

  static final messages = <AppMessage>[];

  static final _streamController = StreamController<dynamic>();
  static Stream<dynamic>? stream;

  static void addMessage({required String text, Color color = Colors.white}) {
    final appMessage = AppMessage(text: text, color: color);
    messages.add(appMessage);
    _streamController.add('change messages');
    Future.delayed(const Duration(seconds: 5), () {
      messages.remove(appMessage);
      _streamController.add('change messages');
    });
  }
}
