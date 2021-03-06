import 'dart:async';

import 'package:crypto_tycoon/domain/entities/token.dart';

enum StatisticsManagerStreamState {
  addBuyPCs,
  addBuyFlats,
  addEnergyConsume,
  addFlatConsume,
  addDealsBuyVolume,
  addDealsSellVolume,
  addTokenEarn,
  addTokenMining,

  addClickerPc,
  addClickerEarn,
  addClickerCrit,
  addDays,
}

class StatisticsManagerStreamEvents {
  StatisticsManagerStreamEvents({
    required this.state,
    this.value,
    this.token,
  });
  final StatisticsManagerStreamState state;
  final dynamic value;
  final Token? token;
}

class StatisticsManager {
  static void init() {
    stream ??= _streamController.stream.asBroadcastStream();
  }

  static final _streamController = StreamController<dynamic>();
  static Stream<dynamic>? stream;

  static void sendMessageStream(StatisticsManagerStreamEvents message) {
    _streamController.add(message);
  }

  Future<void> sendStreamMessage(StatisticsManagerStreamState state, dynamic value, [Token? token]) async {
    _streamController.add(StatisticsManagerStreamEvents(state: state, value: value, token: token));
  }
}
