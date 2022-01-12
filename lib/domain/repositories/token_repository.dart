import 'dart:async';
import 'dart:math';

import 'package:crypto_tycoon/domain/data_providers/token_data_provider.dart';
import 'package:crypto_tycoon/domain/entities/token.dart';
import 'package:crypto_tycoon/domain/repositories/my_repository.dart';
import 'package:crypto_tycoon/initial_data.dart';

enum TokenRepositoryStreamEvent {
  addToken,
  deleteToken,
  changeCount,
  scamToken,
}

class TokenRepository implements MyRepository {
  final _tokenDataProvider = TokenDataProvider();
  static final _streamController = StreamController<dynamic>();
  static Stream<dynamic>? stream;

  var _tokens = <Token>[];
  List<Token> get tokens => List.unmodifiable(_tokens);

  DateTime? lastGeneratedToken;
  int? countWaitDays;
  final _minWaitDays = 30;
  final _maxWaitDays = 90;

  @override
  Future<void> init() async {
    await _tokenDataProvider.openBox();
    stream ??= _streamController.stream.asBroadcastStream();
    updateData();
  }

  @override
  void updateData() {
    _tokens = _tokenDataProvider.loadData();
  }

  Future<void> addToken(Token token) async {
    await _tokenDataProvider.saveData(token);
    updateData();
    _streamController.add(TokenRepositoryStreamEvent.addToken);
  }

  Future<void> deleteToken(Token token) async {
    await _tokenDataProvider.deleteToken(token);
    updateData();
    _streamController.add(TokenRepositoryStreamEvent.deleteToken);
  }

  Future<void> changeCountByToken(Token token, double count) async {
    token.count = double.parse(count.toStringAsFixed(8));
    await token.save();
    _streamController.add(TokenRepositoryStreamEvent.changeCount);
  }

  Future<void> setScamToken(Token token) async {
    token.isScam = true;
    await token.save();
    _streamController.add(TokenRepositoryStreamEvent.scamToken);
  }

  /// Creating token - NoT ADD
  Future<Token?> createToken(DateTime date) async {
    final tokens = _tokenDataProvider.loadData();
    lastGeneratedToken ??= date;
    countWaitDays ??= Random().nextInt(_maxWaitDays - _minWaitDays) + _minWaitDays;
    if (InitialDataNames.nameTokens.length > tokens.length) {
      if (date.isAfter(lastGeneratedToken!.add(Duration(days: countWaitDays!)))) {
        var tokenMap = InitialDataNames.getRandomToken();
        var tokenSymbol = tokenMap.keys.first;
        while (tokens.where((element) => element.symbol == tokenSymbol).isNotEmpty) {
          tokenMap = InitialDataNames.getRandomToken();
          tokenSymbol = tokenMap.keys.first;
        }
        final token =
            InitialData.generateTokens(tokenNames: tokenMap, startIdToken: tokens.length + 1, date: date).first;
        lastGeneratedToken = date;
        countWaitDays = Random().nextInt(_maxWaitDays - _minWaitDays) + _minWaitDays;
        return token;
      } else {
        // no today generate
      }
    } else {
      // max Tokens
    }
  }
}
