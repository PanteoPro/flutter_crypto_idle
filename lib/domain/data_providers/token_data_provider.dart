import 'package:crypto_idle/domain/entities/token.dart';
import 'package:hive/hive.dart';

class TokenDataProvider {
  late Box<Token> _box;

  Future<void> openBox() async {
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(TokenAdapter());
    }
    if (Hive.isBoxOpen('token')) {
      _box = Hive.box<Token>('token');
    } else {
      _box = await Hive.openBox<Token>('token');
    }
  }

  Future<void> deleteToken(Token token) async {
    _box.values.firstWhere((element) => element.id == token.id).delete();
  }

  Future<void> saveToken(Token token) async {
    await _box.add(token);
  }

  List<Token> loadTokens() {
    return [..._box.values];
  }
}
