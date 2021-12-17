import 'package:hive/hive.dart';

abstract class MyHiveDataProvider<T> {
  // ignore: unused_field
  late Box<T> _box;

  Future<void> openBox();
  dynamic loadData();
  Future<void> saveData(T instance);
}
