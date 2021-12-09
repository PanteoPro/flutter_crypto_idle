import 'dart:async';
import 'dart:math';

import 'package:crypto_idle/domain/entities/price_token.dart';
import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/domain/repositories/game_repository.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';
import 'package:crypto_idle/domain/repositories/price_token_repository.dart';
import 'package:crypto_idle/domain/repositories/statistics_repository.dart';
import 'package:crypto_idle/domain/repositories/token_repository.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_view_model.dart';
import 'package:flutter/cupertino.dart';

class GameMarketCryptoViewModelState {
  GameMarketCryptoViewModelState({required this.token, required this.prices});
  GameMarketCryptoViewModelState.empty({this.token, this.prices = const []});

  final Token? token;
  final List<PriceToken> prices;

  PriceToken getLastPrice() {
    return prices.where((element) => element.tokenId == token?.id).last;
  }
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
  final _statisticsRepository = StatisticsRepository();
  StreamSubscription<dynamic>? _tokenStreamSub;
  StreamSubscription<dynamic>? _priceStreamSub;
  StreamSubscription<dynamic>? _gameStreamSub;

  // State Data
  var _state = GameMarketCryptoViewModelState.empty();
  GameMarketCryptoViewModelState get state => _state;

  // Controllers
  final volumeBuyTextController = TextEditingController();
  final volumeSellTextController = TextEditingController();

  /// initial repositories
  Future<void> _initialRepositories() async {
    await _tokenRepository.init();
    await _priceTokenRepository.init();
    await _gameRepository.init();
    await _statisticsRepository.init();
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
      token: token,
      prices: _priceTokenRepository.pricesByTokenId(token.id),
    );
    // if (volumeBuyTextController.text.isEmpty) {
    //   volumeBuyTextController.text = _state.getLastPrice().cost.toString();
    // }
    notifyListeners();
  }

  Future<void> onSellNowButtonPressed() async {
    if (_state.token != null) {
      if (volumeSellTextController.text.isNotEmpty) {
        var volume = double.tryParse(volumeSellTextController.text);
        if (volume != null) {
          volume = max(min(volume, _state.token!.count), 0);
          if (volume > 0) {
            final lastPrice = _state.getLastPrice().cost;
            final income = double.parse((volume * lastPrice).toStringAsFixed(2));

            await _gameRepository.changeData(money: _gameRepository.game.money + income);
            await _tokenRepository.changeToken(_state.token!, count: _state.token!.count - volume);
            await _statisticsRepository.addTokenEarn(_state.token!, income);
            _updateState();
          } else {
            // not Enought tokens
          }
        } else {
          print('Enter num digits');
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
      if (volumeBuyTextController.text.isNotEmpty) {
        var volume = double.tryParse(volumeBuyTextController.text);
        if (volume != null) {
          volume = max(min(volume, _gameRepository.game.money), 0);
          if (volume > 0) {
            final lastPrice = _state.getLastPrice().cost;
            final countTokens = double.parse((volume / lastPrice).toStringAsFixed(8));

            await _gameRepository.changeData(money: _gameRepository.game.money - volume);
            await _tokenRepository.changeToken(_state.token!, count: _state.token!.count + countTokens);
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

  void onChangeSellVolumeButtonPressed(PercentButton choice) {
    volumeSellTextController.text = (choice.value * (_state.token?.count ?? 0)).toStringAsFixed(8);
  }

  void onChangeBuyVolumeButtonPressed(PercentButton choice) {
    volumeBuyTextController.text = (choice.value * (_gameRepository.game.money)).toStringAsFixed(2);
  }
}

enum PercentButton { p25, p50, p75, p100 }

extension PercentButtonValues on PercentButton {
  static const values = [0.25, 0.5, 0.75, 1.0];
  double get value => values[index];
}
