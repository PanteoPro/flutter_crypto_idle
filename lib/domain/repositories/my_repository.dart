import 'dart:async';

abstract class MyRepository {
  /// _data = await _dataProvider.loadData();
  void updateData();
  Future<void> init();
}
