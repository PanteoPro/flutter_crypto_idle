import 'package:crypto_idle/domain/data_providers/token_data_provider.dart';
import 'package:crypto_idle/domain/entities/token.dart';

class TokenRepository {
  final _tokenDataProvider = TokenDataProvider();

  var _tokens = <Token>[];
  List<Token> get tokens => List.unmodifiable(_tokens);

  Future<void> init() async {
    await _tokenDataProvider.openBox();
    _updateData();
  }

  Future<void> addToken(Token token) async {
    await _tokenDataProvider.saveToken(token);
    _updateData();
  }

  Future<void> deleteToken(Token token) async {
    await _tokenDataProvider.deleteToken(token);
    _updateData();
  }

  void _updateData() {
    _tokens = _tokenDataProvider.loadTokens();
  }
}
