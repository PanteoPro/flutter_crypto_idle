import 'dart:async';
import 'dart:math';

import 'package:crypto_idle/domain/repositories/statistics_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:crypto_idle/domain/entities/price_token.dart';
import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/domain/repositories/game_repository.dart';
import 'package:crypto_idle/domain/repositories/message_manager.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';
import 'package:crypto_idle/domain/repositories/price_token_repository.dart';
import 'package:crypto_idle/domain/repositories/statistics_repository.dart';
import 'package:crypto_idle/domain/repositories/token_repository.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/global/game_view_model.dart';

class GameMarketCryptoViewModelState {
  GameMarketCryptoViewModelState({
    required this.money,
    required this.token,
    required this.prices,
    this.percentBuy = 0,
    this.percentSell = 0,
  });
  GameMarketCryptoViewModelState.empty({
    this.money = 0,
    this.token,
    this.prices = const [],
    this.percentBuy = 0,
    this.percentSell = 0,
  });

  final double money;
  final Token? token;
  final List<PriceToken> prices;
  double percentBuy;
  double percentSell;

  PriceToken getLastPrice() {
    return prices.isNotEmpty ? prices.where((element) => element.tokenId == token?.id).last : PriceToken.empty();
  }

  double get dollarAsset => token != null ? token!.count * getLastPrice().cost : 0;

  double get buyVolumeDollar => double.parse((percentBuy * money).toStringAsFixed(2));
  double get buyVolumeToken =>
      !token!.isScam ? double.parse((buyVolumeDollar / getLastPrice().cost).toStringAsFixed(8)) : 0;

  double get sellVolumeDollar => double.parse((sellVolumeToken * getLastPrice().cost).toStringAsFixed(2));
  double get sellVolumeToken => double.parse((percentSell * (token?.count ?? 0)).toStringAsFixed(8));
}

class GameMarketCryptoViewModel extends ChangeNotifier {
  GameMarketCryptoViewModel({required Token token}) {
    _state = GameMarketCryptoViewModelState.empty(token: token);
    _initialRepositories();
    _subscriteStreams();
  }

  @override
  void dispose() {
    _tokenStreamSub?.cancel();
    _priceStreamSub?.cancel();
    _gameStreamSub?.cancel();
    super.dispose();
  }

  // Repository
  final _tokenRepository = TokenRepository();
  final _priceTokenRepository = PriceTokenRepository();
  final _gameRepository = GameRepository();
  StreamSubscription<dynamic>? _tokenStreamSub;
  StreamSubscription<dynamic>? _priceStreamSub;
  StreamSubscription<dynamic>? _gameStreamSub;

  // State Data
  var _state = GameMarketCryptoViewModelState.empty();
  GameMarketCryptoViewModelState get state => _state;

  /// initial repositories
  Future<void> _initialRepositories() async {
    await _tokenRepository.init();
    await _priceTokenRepository.init();
    await _gameRepository.init();
    _updateState();
  }

  /// subscribe to repositories Streams
  void _subscriteStreams() {
    _tokenStreamSub = TokenRepository.stream?.listen(
      (dynamic data) => _updateRepoByChangeEvent(data, _tokenRepository),
    );
    _priceStreamSub = PriceTokenRepository.stream?.listen(
      (dynamic data) => _updateRepoByChangeEvent(data, _priceTokenRepository),
    );
    _gameStreamSub = GameRepository.stream?.listen(
      (dynamic data) => _updateRepoByChangeEvent(data, _gameRepository),
    );
  }

  /// Update date from repository, because data changed
  Future<void> _updateRepoByChangeEvent(dynamic data, MyRepository repository) async {
    repository.updateData();
    _updateState();
  }

  void _updateState() {
    final token = _tokenRepository.tokens.firstWhere((element) => element.id == _state.token?.id);
    _state = GameMarketCryptoViewModelState(
      money: _gameRepository.game.money,
      token: token,
      prices: _priceTokenRepository.pricesByTokenId(token.id),
      percentBuy: _state.percentBuy,
      percentSell: _state.percentSell,
    );
    // if (volumeBuyTextController.text.isEmpty) {
    //   volumeBuyTextController.text = _state.getLastPrice().cost.toString();
    // }
    notifyListeners();
  }

  Future<void> onSellNowButtonPressed() async {
    if (_state.token != null) {
      if (_state.percentSell > 0) {
        var volume = _state.sellVolumeToken;
        volume = max(min(volume, _state.token!.count), 0);
        if (volume > 0) {
          final lastPrice = _state.getLastPrice().cost;
          final income = double.parse((volume * lastPrice).toStringAsFixed(2));

          await _gameRepository.changeMoney(income);
          await _tokenRepository.changeCountByToken(_state.token!, _state.token!.count - volume);
          StatisticsManager.sendMessageStream(
            StatisticsManagerStreamEvents(
              state: StatisticsManagerStreamState.addDealsSellVolume,
              value: income,
            ),
          );
          StatisticsManager.sendMessageStream(
            StatisticsManagerStreamEvents(
              state: StatisticsManagerStreamState.addTokenEarn,
              value: income,
              token: _state.token,
            ),
          );
          _state.percentSell = 0;
          MessageManager.addMessage(
            text: 'Продано $volume ${_state.token!.symbol} по цене $lastPrice, вы получили $income\$',
            color: Colors.red,
          );
          _updateState();
        } else {
          // not Enought tokens
        }
      } else {
        print('Enter volume!');
      }
    } else {
      print('Token not find');
    }
  }

  Future<void> onBuyNowButtonPressed() async {
    if (_state.token != null) {
      if (_state.percentBuy > 0) {
        var volume = _state.buyVolumeDollar;
        if (volume != null) {
          volume = max(min(volume, _gameRepository.game.money), 0);
          if (volume > 0) {
            final lastPrice = _state.getLastPrice().cost;
            final countTokens = double.parse((volume / lastPrice).toStringAsFixed(8));

            await _gameRepository.changeMoney(-volume);
            await _tokenRepository.changeCountByToken(_state.token!, _state.token!.count + countTokens);
            _state.percentBuy = 0;
            StatisticsManager.sendMessageStream(
              StatisticsManagerStreamEvents(
                state: StatisticsManagerStreamState.addDealsBuyVolume,
                value: volume,
                token: _state.token,
              ),
            );
            MessageManager.addMessage(
              text: 'Куплено $countTokens ${_state.token!.symbol} по цене $lastPrice. Вы потратили $volume\$',
              color: Colors.green,
            );
            _updateState();
          } else {
            // not enough money
          }
        } else {
          // error volume
        }
      } else {
        // error message
      }
    } else {
      // erorr message
    }
  }

  void onChangeSliderBuy(double newValue) {
    if (!_state.token!.isScam) {
      _state.percentBuy = newValue;
      notifyListeners();
    }
  }

  void onChangeSliderSell(double newValue) {
    if (!_state.token!.isScam) {
      _state.percentSell = newValue;
      notifyListeners();
    }
  }
}

enum PercentButton { p25, p50, p75, p100 }

extension PercentButtonValues on PercentButton {
  static const values = [0.25, 0.5, 0.75, 1.0];
  double get value => values[index];
}
