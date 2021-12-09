import 'dart:async';

import 'package:crypto_idle/domain/data_providers/statistics_data_provider.dart';
import 'package:crypto_idle/domain/entities/statistics.dart';
import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';

class StatisticsRepository implements MyRepository {
  final _statisticsDataProvider = StatisticsDataProvider();

  static final _streamController = StreamController<dynamic>();
  static Stream<dynamic>? stream;

  var _statistics = Statistics.empty();
  Statistics get statistics => _statistics;

  @override
  Future<void> init() async {
    await _statisticsDataProvider.openBox();
    stream ??= _streamController.stream.asBroadcastStream();
    updateData();
  }

  @override
  void updateData() {
    _statistics = _statisticsDataProvider.loadData();
  }

  Future<void> addEnergyConsume(List<double> energyConsume) async {
    _statistics.energyConsume.addAll(energyConsume);
    await _statisticsDataProvider.saveData(_statistics);
    updateData();
    _streamController.add('add energy Consume');
  }

  Future<void> addFlatConsume(double flatConsume) async {
    _statistics.flatConsume.add(flatConsume);
    await _statisticsDataProvider.saveData(_statistics);
    updateData();
    _streamController.add('add flat Consume');
  }

  Future<void> addPCConsume(double pcConsume) async {
    _statistics.pcConsume.add(pcConsume);
    await _statisticsDataProvider.saveData(_statistics);
    updateData();
    _streamController.add('add pc Consume');
  }

  Future<void> addTokenEarn(Token token, double earnCash) async {
    if (_statistics.tokenEarn[token.id] == null) {
      _statistics.tokenEarn[token.id] = [];
    }
    _statistics.tokenEarn[token.id]?.add(earnCash);
    await _statisticsDataProvider.saveData(_statistics);
    updateData();
    _streamController.add('add earn cash');
  }

  Future<void> addTokenMining(Token token, double miningValue) async {
    if (_statistics.tokenMining[token.id] == null) {
      _statistics.tokenMining[token.id] = [];
    }
    _statistics.tokenMining[token.id]?.add(miningValue);
    await _statisticsDataProvider.saveData(_statistics);
    updateData();
    _streamController.add('add earn mining');
  }
}
