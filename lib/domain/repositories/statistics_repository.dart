import 'dart:async';

import 'package:crypto_idle/domain/data_providers/statistics_data_provider.dart';
import 'package:crypto_idle/domain/entities/statistics.dart';
import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';
import 'package:crypto_idle/domain/repositories/statistics_manager.dart';

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

  Future<void> _save(StatisticsManagerStreamState event) async {
    await _statisticsDataProvider.saveData(_statistics);
    updateData();
    _streamController.add(event);
  }

  Future<void> addBuyPCs(double pcCost) async {
    _statistics.buyPCs.add(pcCost);
    await _save(StatisticsManagerStreamState.addBuyPCs);
  }

  Future<void> addBuyFlats(double flatCost) async {
    _statistics.buyFlats.add(flatCost);
    await _save(StatisticsManagerStreamState.addBuyFlats);
  }

  Future<void> addEnergyConsume(double energyConsume) async {
    _statistics.energyConsume.add(energyConsume);
    await _save(StatisticsManagerStreamState.addEnergyConsume);
  }

  Future<void> addFlatConsume(double flatConsume) async {
    _statistics.flatConsume.add(flatConsume);
    await _save(StatisticsManagerStreamState.addFlatConsume);
  }

  Future<void> addDealsBuyVolume(double dealVolume) async {
    _statistics.dealsBuyVolume.add(dealVolume);
    await _save(StatisticsManagerStreamState.addDealsBuyVolume);
  }

  Future<void> addDealsSellVolume(double dealVolume) async {
    _statistics.dealsSellVolume.add(dealVolume);
    await _save(StatisticsManagerStreamState.addDealsSellVolume);
  }

  Future<void> addTokenEarn(Token token, double earnCash) async {
    if (_statistics.tokenEarn[token.id] == null) {
      _statistics.tokenEarn[token.id] = [];
    }
    _statistics.tokenEarn[token.id]?.add(earnCash);
    await _save(StatisticsManagerStreamState.addTokenEarn);
  }

  Future<void> addTokenMining(Token token, double miningValue) async {
    if (_statistics.tokenMining[token.id] == null) {
      _statistics.tokenMining[token.id] = [];
    }
    _statistics.tokenMining[token.id]?.add(miningValue);
    await _save(StatisticsManagerStreamState.addTokenMining);
  }

  // addClickerPc,
  // addClickerEarn,
  // addClickerCrit,
  // addDays,

  Future<void> addClickerPc() async {
    _statistics.clickedPC += 1;
    await _save(StatisticsManagerStreamState.addClickerPc);
  }

  Future<void> addClickerEarn(double earn) async {
    _statistics.clickerEarn.add(earn);
    await _save(StatisticsManagerStreamState.addClickerEarn);
  }

  Future<void> addClickerCrit() async {
    _statistics.clickedPCCrits += 1;
    await _save(StatisticsManagerStreamState.addClickerCrit);
  }

  Future<void> addDays() async {
    _statistics.countDays += 1;
    await _save(StatisticsManagerStreamState.addDays);
  }
}
