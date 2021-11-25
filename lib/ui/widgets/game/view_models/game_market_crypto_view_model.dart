import 'dart:math';

import 'package:crypto_idle/domain/entities/price_token.dart';
import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/domain/repositories/game_repository.dart';
import 'package:crypto_idle/domain/repositories/price_token_repository.dart';
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
    initialRepositories();
  }

  final _tokenRepository = TokenRepository();
  final _priceTokenRepository = PriceTokenRepository();
  final _gameRepository = GameRepository();

  var _state = GameMarketCryptoViewModelState.empty();
  GameMarketCryptoViewModelState get state => _state;

  final priceTextController = TextEditingController();
  final volumeTextController = TextEditingController();

  Future<void> initialRepositories() async {
    await _tokenRepository.init();
    await _priceTokenRepository.init();
    await _gameRepository.init();
    _updateState();
  }

  void _updateState() {
    final token = _tokenRepository.tokens.firstWhere((element) => element.id == _state.token?.id);
    _state = GameMarketCryptoViewModelState(
      token: token,
      prices: _priceTokenRepository.prices,
    );
    if (priceTextController.text.isEmpty) {
      priceTextController.text = _state.getLastPrice().cost.toString();
    }
    notifyListeners();
  }

  Future<void> onSellNowButtonPressed(GameViewModel gmv) async {
    if (_state.token != null) {
      if (volumeTextController.text.isNotEmpty) {
        var volume = double.tryParse(volumeTextController.text);
        if (volume != null) {
          volume = min(volume, _state.token!.count);
          final lastPrice = _state.getLastPrice().cost;
          final income = double.parse((volume * lastPrice).toStringAsFixed(2));

          await _gameRepository.changeData(money: _gameRepository.game.money + income);
          await _tokenRepository.changeToken(_state.token!, count: _state.token!.count - volume);
          await gmv.TEMP_UPDAGE_DATA();
          _updateState();
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

  void onSellLimitButtonPressed(GameViewModel gmv) {
    if (priceTextController.text.isNotEmpty) {
      if (volumeTextController.text.isNotEmpty) {
        // do somethink
      } else {
        // error message
      }
    } else {
      // erorr message
    }
  }

  void onChangeVolumeButtonPressed(PercentButton choice) {
    volumeTextController.text = (choice.value * (_state.token?.count ?? 0)).toStringAsFixed(8);
  }
}

enum PercentButton { p25, p50, p75, p100 }

extension PercentButtonValues on PercentButton {
  static const values = [0.25, 0.5, 0.75, 1.0];
  double get value => values[index];
}
