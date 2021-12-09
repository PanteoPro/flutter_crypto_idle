import 'dart:async';

import 'package:crypto_idle/domain/data_providers/token_data_provider.dart';
import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';

class TokenRepository implements MyRepository {
  final _tokenDataProvider = TokenDataProvider();
  static final _streamController = StreamController<dynamic>();
  static Stream<dynamic>? stream;

  var _tokens = <Token>[];
  List<Token> get tokens => List.unmodifiable(_tokens);

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
    _streamController.add('Addtoken');
  }

  Future<void> deleteToken(Token token) async {
    await _tokenDataProvider.deleteToken(token);
    updateData();
    _streamController.add('DeleteToken');
  }

  Future<void> changeToken(Token token, {double? count}) async {
    if (count != null) {
      token.count = double.parse(count.toStringAsFixed(8));
      await token.save();
      _streamController.add('ChangeToken');
    }
  }
}
