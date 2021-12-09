import 'package:crypto_idle/domain/entities/price_token.dart';
import 'package:hive/hive.dart';

abstract class MyHiveDataProvider<T> {
  late Box<T> _box;

  Future<void> openBox();
  dynamic loadData();
  Future<void> saveData(T instance);
}
