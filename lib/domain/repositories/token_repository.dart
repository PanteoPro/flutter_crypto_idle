import 'package:crypto_idle/domain/data_providers/token_data_provider.dart';
import 'package:crypto_idle/domain/entities/token.dart';

class TokenRepository {
  final _tokenDataProvider = TokenDataProvider();

  var _tokens = <Token>[];
  List<Token> get tokens => List.unmodifiable(_tokens);

  Future<void> init() async {
    await _tokenDataProvider.openBox();
    updateData();
  }

  Future<void> addToken(Token token) async {
    await _tokenDataProvider.saveToken(token);
    updateData();
  }

  Future<void> deleteToken(Token token) async {
    await _tokenDataProvider.deleteToken(token);
    updateData();
  }

  Future<void> changeToken(Token token, {double? count}) async {
    if (count != null) {
      token.count = double.parse(count.toStringAsFixed(8));
      await token.save();
    }
  }

  void updateData() {
    _tokens = _tokenDataProvider.loadTokens();
  }
}
