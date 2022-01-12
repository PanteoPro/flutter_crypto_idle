import 'dart:async';
import 'dart:math';

import 'package:crypto_tycoon/domain/repositories/message_manager.dart';
import 'package:flutter/material.dart';

class MessageStreamViewModel extends ChangeNotifier {
  MessageStreamViewModel() {
    _messageStreamSub = MessageManager.stream?.listen((event) {
      _messages = List.unmodifiable(MessageManager.messages.reversed);
      notifyListeners();
    });
  }
  @override
  void dispose() {
    _messageStreamSub?.cancel();
    super.dispose();
  }

  StreamSubscription<dynamic>? _messageStreamSub;
  List<AppMessage> _messages = [];
  List<AppMessage> get messages => _messages.sublist(0, min(_messages.length, 3));
}
