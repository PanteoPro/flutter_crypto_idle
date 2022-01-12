import 'package:crypto_tycoon/domain/data_providers/my_hive_data_provider.dart';
import 'package:crypto_tycoon/domain/entities/token.dart';
import 'package:hive/hive.dart';

class TokenDataProvider implements MyHiveDataProvider<Token> {
  late Box<Token> _box;

  @override
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

  @override
  List<Token> loadData() {
    return [..._box.values];
  }

  @override
  Future<void> saveData(Token token) async {
    await _box.add(token);
  }

  Future<void> deleteToken(Token token) async {
    _box.values.firstWhere((element) => element.id == token.id).delete();
  }
}
