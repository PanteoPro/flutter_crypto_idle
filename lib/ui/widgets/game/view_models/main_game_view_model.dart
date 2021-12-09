import 'dart:async';
import 'package:collection/collection.dart';
import 'package:crypto_idle/domain/entities/flat.dart';
import 'package:crypto_idle/domain/entities/pc.dart';
import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/domain/repositories/flat_repository.dart';

import 'package:crypto_idle/domain/repositories/my_repository.dart';
import 'package:crypto_idle/domain/repositories/pc_repository.dart';
import 'package:crypto_idle/domain/repositories/token_repository.dart';
import 'package:crypto_idle/ui/navigators/main_navigator.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_view_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:crypto_idle/domain/entities/statistics.dart';
import 'package:crypto_idle/domain/repositories/statistics_repository.dart';

class MainGameViewModelState {
  MainGameViewModelState({
    required this.statistics,
    required this.tokens,
    required this.myPCs,
    required this.flat,
    required this.isModalShow,
  });
  MainGameViewModelState.empty({
    Statistics? statistics,
    List<Token>? tokens,
    List<PC>? myPCs,
    Flat? flat,
    bool? isModalShow,
  }) {
    this.statistics = statistics ?? Statistics.empty();
    this.tokens = tokens ?? [];
    this.myPCs = myPCs ?? [];
    this.flat = flat ?? Flat.empty();
    this.isModalShow = isModalShow ?? false;
  }

  late Statistics statistics;
  late List<Token> tokens;
  late List<PC> myPCs;
  late Flat flat;
  double get flatConsume => flat.costMonth;
  double get energyConsumeCost => energyConsume / 10;
  double get energyConsume {
    var energy = 0.0;
    for (final element in myPCs) {
      if (element.miningToken != null) {
        energy += element.energy;
      }
    }
    return energy;
  }

  double get powerPCs {
    var power = 0.0;
    for (final element in myPCs) {
      if (element.miningToken != null) {
        power += element.power;
      }
    }
    return power;
  }

  bool isModalShow = false;

  double get sumFlatConsume => statistics.flatConsume.sum;
  double get sumEnergyConsume => statistics.energyConsume.sum;
  double get sumPCConsume => statistics.pcConsume.sum;
  double get sumConsume => sumFlatConsume + sumEnergyConsume + sumPCConsume;

  double earnTokensByTokenId(int tokenId) {
    return statistics.tokenEarn[tokenId]?.sum ?? 0;
  }

  double miningTokensByTokenId(int tokenId) {
    return statistics.tokenMining[tokenId]?.sum ?? 0;
  }
}

class MainGameViewModel extends ChangeNotifier {
  MainGameViewModel() {
    _initialRepositories();
  }

  @override
  void dispose() {
    _statisticsStreamSub?.cancel();
    _tokensStreamSub?.cancel();
    _flatStreamSub?.cancel();
    _pcStreamSub?.cancel();
    super.dispose();
  }

  final _statisticsRepository = StatisticsRepository();
  final _tokensRepository = TokenRepository();
  final _flatRepository = FlatRepository();
  final _pcRepository = PCRepository();
  StreamSubscription<dynamic>? _statisticsStreamSub;
  StreamSubscription<dynamic>? _tokensStreamSub;
  StreamSubscription<dynamic>? _flatStreamSub;
  StreamSubscription<dynamic>? _pcStreamSub;

  var _state = MainGameViewModelState.empty();
  MainGameViewModelState get state => _state;

  Future<void> _initialRepositories() async {
    await _statisticsRepository.init();
    await _tokensRepository.init();
    await _flatRepository.init();
    await _pcRepository.init();
    _subscriteStreams();
    await _updateState();
  }

  void _subscriteStreams() {
    _statisticsStreamSub =
        StatisticsRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _statisticsRepository));
    _tokensStreamSub =
        TokenRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _tokensRepository));
    _flatStreamSub = FlatRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _flatRepository));
    _pcStreamSub = PCRepository.stream?.listen((dynamic data) => _updateRepoByChangeEvent(data, _pcRepository));
  }

  Future<void> _updateRepoByChangeEvent(dynamic data, MyRepository repository) async {
    await repository.updateData();
    _updateState();
  }

  Future<void> _updateState() async {
    _state = MainGameViewModelState(
      statistics: _statisticsRepository.statistics,
      tokens: _tokensRepository.tokens,
      flat: _flatRepository.currentFlat,
      myPCs: _pcRepository.pcs,
      isModalShow: _state.isModalShow,
    );
    notifyListeners();
  }

  void onReturnToMenuButtonPressed() {
    _state.isModalShow = !_state.isModalShow;
    notifyListeners();
  }

  void onYesExitButtonPressed(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.menu);
  }

  void onNoExitButtonPressed() {
    _state.isModalShow = false;
    notifyListeners();
  }
}
